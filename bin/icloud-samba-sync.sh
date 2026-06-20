#!/bin/sh
# Syncs a local iCloud folder to a Samba file server share.
#
# Configuration is read from the first file found among:
#   $ICLOUD_SAMBA_SYNC_CONFIG
#   ~/.config/local/icloud-samba-sync.conf
#
# Run with --dry-run to preview changes without writing anything.
# Run with --unmount to unmount the share after syncing (default: leave mounted).
#
# Schedule via launchd — see the companion plist in dotfiles/launchd/.

set -e

# ── helpers ──────────────────────────────────────────────────────────────────

log() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

die() {
    log "ERROR: $*" >&2
    exit 1
}

usage() {
    cat <<EOF
Usage: $(basename "$0") [--dry-run] [--unmount] [--help]

  --dry-run   Preview changes without syncing or mounting
  --unmount   Unmount the Samba share after a successful sync
  --help      Show this message
EOF
    exit 0
}

# ── argument parsing ──────────────────────────────────────────────────────────

DRY_RUN=0
AUTO_UNMOUNT=0

for arg in "$@"; do
    case "$arg" in
        --dry-run)  DRY_RUN=1 ;;
        --unmount)  AUTO_UNMOUNT=1 ;;
        --help|-h)  usage ;;
        *)          die "Unknown argument: $arg" ;;
    esac
done

# ── load config ───────────────────────────────────────────────────────────────

CONFIG_FILE="${ICLOUD_SAMBA_SYNC_CONFIG:-$HOME/.config/local/icloud-samba-sync.conf}"

[ -f "$CONFIG_FILE" ] || die "Config file not found: $CONFIG_FILE
Create it from the template:
  cp ~/.dotfiles/local/icloud-samba-sync.conf.template $CONFIG_FILE
  \$EDITOR $CONFIG_FILE"

# shellcheck source=/dev/null
. "$CONFIG_FILE"

# ── validate config ───────────────────────────────────────────────────────────

for var in SAMBA_HOST SAMBA_SHARE SAMBA_USER SOURCE_DIR; do
    eval "val=\$$var"
    [ -n "$val" ] || die "Required config variable not set: $var"
done

# Defaults for optional variables
SAMBA_MOUNT_POINT="${SAMBA_MOUNT_POINT:-/Volumes/samba-sync}"
# Destination path relative to the share root (empty = share root)
DEST_SUBDIR="${DEST_SUBDIR:-}"
LOG_FILE="${LOG_FILE:-$HOME/Library/Logs/icloud-samba-sync.log}"

DEST_DIR="${SAMBA_MOUNT_POINT}${DEST_SUBDIR:+/$DEST_SUBDIR}"

# ── resolve source path ───────────────────────────────────────────────────────

# Expand ~ manually since sh doesn't expand it inside variables
SOURCE_DIR="$(eval echo "$SOURCE_DIR")"
[ -d "$SOURCE_DIR" ] || die "Source directory does not exist: $SOURCE_DIR"

# ── network reachability ──────────────────────────────────────────────────────

check_host_reachable() {
    ping -c 1 -W 2000 "$SAMBA_HOST" >/dev/null 2>&1
}

if ! check_host_reachable; then
    log "Host $SAMBA_HOST is not reachable — skipping sync."
    exit 0
fi

# ── mount ─────────────────────────────────────────────────────────────────────

mount_share() {
    log "Mounting //$SAMBA_HOST/$SAMBA_SHARE ..."

    mkdir -p "$SAMBA_MOUNT_POINT"

    # Prefer credentials from the macOS Keychain; fall back to the config var.
    if [ -z "$SAMBA_PASSWORD" ]; then
        SAMBA_PASSWORD="$(security find-internet-password \
            -s "$SAMBA_HOST" -a "$SAMBA_USER" -w 2>/dev/null)" \
            || die "No password found in Keychain for $SAMBA_USER@$SAMBA_HOST.
Add it with:
  security add-internet-password -s '$SAMBA_HOST' -a '$SAMBA_USER' -w"
    fi

    # mount_smbfs treats special characters in the URL; use env var instead.
    SMBFS_USER="$SAMBA_USER" \
    mount_smbfs \
        "//${SAMBA_USER}:${SAMBA_PASSWORD}@${SAMBA_HOST}/${SAMBA_SHARE}" \
        "$SAMBA_MOUNT_POINT" \
        || die "mount_smbfs failed."

    log "Mounted at $SAMBA_MOUNT_POINT"
}

unmount_share() {
    log "Unmounting $SAMBA_MOUNT_POINT ..."
    diskutil unmount "$SAMBA_MOUNT_POINT" >/dev/null \
        && log "Unmounted." \
        || log "WARNING: unmount failed (share may still be in use)."
}

share_is_mounted() {
    mount | grep -q " on ${SAMBA_MOUNT_POINT} "
}

MOUNTED_BY_US=0

if share_is_mounted; then
    log "Share already mounted at $SAMBA_MOUNT_POINT"
elif [ "$DRY_RUN" -eq 1 ]; then
    log "[dry-run] Would mount //$SAMBA_HOST/$SAMBA_SHARE at $SAMBA_MOUNT_POINT"
else
    mount_share
    MOUNTED_BY_US=1
fi

# ── rsync ─────────────────────────────────────────────────────────────────────

# Ensure source path ends with / so rsync copies contents, not the directory itself.
RSYNC_SOURCE="${SOURCE_DIR%/}/"

RSYNC_OPTS="-rlptD"           # archive minus -o/-g: don't push Mac ownership to Samba
RSYNC_OPTS="$RSYNC_OPTS -h"   # human-readable numbers
RSYNC_OPTS="$RSYNC_OPTS --progress"
RSYNC_OPTS="$RSYNC_OPTS --log-file=$LOG_FILE"
RSYNC_OPTS="$RSYNC_OPTS --exclude='.DS_Store'"
RSYNC_OPTS="$RSYNC_OPTS --exclude='*.icloud'"     # iCloud stubs (not downloaded locally)
RSYNC_OPTS="$RSYNC_OPTS --exclude='.Spotlight-V100'"
RSYNC_OPTS="$RSYNC_OPTS --exclude='.TemporaryItems'"
RSYNC_OPTS="$RSYNC_OPTS --exclude='.Trashes'"
RSYNC_OPTS="$RSYNC_OPTS --exclude='Icon?'"        # macOS custom folder icons
RSYNC_OPTS="$RSYNC_OPTS --exclude='desktop.ini'"  # Windows cruft written by Samba

# Uncomment to delete files on the destination that no longer exist on the source.
# Be careful — this makes the sync destructive in one direction.
# RSYNC_OPTS="$RSYNC_OPTS --delete --delete-excluded"

if [ "$DRY_RUN" -eq 1 ]; then
    RSYNC_OPTS="$RSYNC_OPTS --dry-run"
    log "[dry-run] rsync $RSYNC_SOURCE -> $DEST_DIR"
else
    log "Syncing $RSYNC_SOURCE -> $DEST_DIR"
fi

# shellcheck disable=SC2086
rsync $RSYNC_OPTS "$RSYNC_SOURCE" "$DEST_DIR"

log "Sync complete."

# ── unmount ───────────────────────────────────────────────────────────────────

if [ "$AUTO_UNMOUNT" -eq 1 ] && [ "$MOUNTED_BY_US" -eq 1 ] && [ "$DRY_RUN" -eq 0 ]; then
    unmount_share
fi
