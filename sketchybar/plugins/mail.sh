#!/bin/sh

# Shows the unread count in Mail's inbox. Only asks while Mail is running, as
# asking would otherwise launch it.

. "$(dirname "$0")/badge.sh"

if pgrep -xq Mail; then
  UNREAD="$(osascript -e 'tell application "Mail" to get unread count of inbox')"
  set_badge "$UNREAD"
else
  sketchybar --set "$NAME" drawing=off
fi
