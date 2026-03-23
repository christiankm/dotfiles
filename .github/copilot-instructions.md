# GitHub Copilot Instructions for dotfiles

## Repository Overview

This is a personal dotfiles repository for managing macOS system configuration, application installations, and development environment setup. The repository uses **Ansible** for idempotent automation, ensuring consistent installations across machines.

**Repository location:** `~/.dotfiles`
**Primary OS:** macOS (Darwin) - supports both Apple Silicon and Intel
**Automation tool:** Ansible 2.x with community.general collection
**Package manager:** Homebrew + Mac App Store (via `mas`)
**Shell:** zsh with oh-my-zsh framework and powerlevel10k theme
**Configuration approach:** Symlink dotfiles from `~/.dotfiles` to home directory

## Project Structure

```
~/.dotfiles/
├── ansible/
│   ├── playbooks/          # 15 Ansible playbooks (~532 lines total)
│   ├── tasks/              # Reusable Ansible tasks
│   └── vars/main.yml       # Package lists and variables
├── bash/                   # Bash aliases and functions
│   ├── aliases.sh          # 55+ shell aliases
│   └── functions/          # Shell functions (e.g., task.sh)
├── git/                    # Git configuration
│   ├── .gitconfig          # Global git config (includes local)
│   ├── .gitignore_global   # Global gitignore patterns
│   └── commit-template     # Git commit message template
├── zsh/                    # zsh configuration
│   ├── .zshrc              # Main zsh config with plugins
│   ├── .zprofile           # zsh profile for PATH setup
│   └── .p10k.zsh           # Powerlevel10k theme config (auto-generated)
├── vim/                    # Vim/Neovim configuration
│   ├── .vimrc              # Vim settings with gruvbox theme
│   ├── plugins/            # Vim plugins
│   └── after/              # Vim after-load scripts
├── ssh/                    # SSH configuration templates
├── tmux/                   # tmux configuration
├── todo/                   # todo.txt configuration
├── terminal/               # Terminal themes (Dark.terminal)
├── xcode/                  # Xcode themes and settings
├── resources/fonts/        # Custom fonts (not all tracked)
├── bin/                    # User scripts and binaries
├── local/                  # Machine-specific configs (not tracked)
├── install.sh              # Main installation script
├── update.sh               # Git pull + reinstall
└── configure-macos-preferences.sh  # macOS system preferences via defaults
```

## Code Style and Standards

### Shell Scripts (.sh)

- **Shell dialect:** bash
- **Indentation:** 4 spaces
- **Line endings:** LF (Unix)
- **Linter:** shellcheck with all optional checks enabled
- **Disabled checks:** SC1091, SC2250, SC2086, SC2139, SC2292, SC2155, SC2312, SC2034, SC2230
- **Style:**
  - Use `set -e` to stop on errors
  - Quote all variables to prevent word splitting
  - Use `[[ ]]` instead of `[ ]` for conditionals
  - Prefer `$(command)` over backticks
  - Add comments only for complex logic

### YAML Files (Ansible/Workflows)

- **Indentation:** 2 spaces
- **Line endings:** LF (Unix)
- **Linters:** yamllint (default + custom rules), ansible-lint (moderate profile)
- **yamllint rules:**
  - Max line length: 100 characters
  - Allow 0-1 spaces inside braces/brackets
  - Comments: min 1 space from content, no starting space required
  - Truthy: disabled (allow yes/no, on/off)
- **ansible-lint rules:**
  - Profile: moderate
  - Max block depth: 20
  - Task names: prefixed with `{stem} | `
  - Loop variables: must start with `__` or role name
  - Variable naming: `^[a-z_][a-z0-9_]*$` (snake_case)
  - Use fully qualified collection names (e.g., `ansible.builtin.file`)
  - Set `changed_when` for command tasks to avoid false positives
  - Use `gather_facts: true` only when needed

### Markdown Files

- **Line endings:** LF (Unix)
- **Trailing whitespace:** Preserved (not trimmed)

### General

- **Encoding:** UTF-8
- **Final newline:** Always insert
- **Trailing whitespace:** Trim (except Markdown)

## Key Technologies

### Automation Stack

- **Ansible:** Primary automation tool
  - Config: `ansible.cfg` (local connection, no cows, Python auto-detect)
  - Inventory: `inventory.ini` (localhost only)
  - Collections: `community.general` (required for Homebrew module)
  - Entry point: `ansible/playbooks/main.yml`
  - Logs: `ansible.log` (git-ignored)

### Package Management

- **Homebrew:** CLI tools and GUI applications (casks)
  - Analytics disabled: `HOMEBREW_NO_ANALYTICS=1`
  - Paths: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel)
- **mas:** Mac App Store CLI tool
  - Requires prior purchase/download of apps
  - Managed via `homebrew_mas_apps` list in `ansible/vars/main.yml`

### Shell Environment

- **zsh:** Default shell
- **oh-my-zsh:** Framework with plugins:
  - dotnet, fzf, gh, git, git-lfs, macos, pre-commit, swiftpm, ruby, tmux, xcode
  - zsh-syntax-highlighting, zsh-autosuggestions
- **powerlevel10k:** Prompt theme (config: `.p10k.zsh`)
- **rbenv:** Ruby version manager
- **nvm:** Node.js version manager (optional)

### Development Tools

- **Git:** Version control with custom configuration
  - Default branch: `main`
  - Pull strategy: `rebase = true`
  - Fetch: `prune = true`
  - Local user config: `~/.config/local/.gitconfig_local` (not tracked)
- **Vim/Neovim:** Text editor
  - Theme: gruvbox (auto-switches with macOS appearance)
  - Line numbers: relative
  - Indentation: 4 spaces
  - Plugins: managed in `vim/plugins/`
- **tmux:** Terminal multiplexer
- **todo.txt:** Task management CLI

### Installed Packages (Highlights)

**Global packages:**

- ansible, ansible-lint, actionlint
- shellcheck, yamllint, swiftformat
- vim, neovim, tmux, htop, coreutils, mas

**User packages (machine-specific):**

- copilot-cli, todo-txt, xcodes
- dotnet@8, dotnet@9
- aria2

**Cask apps:**

- Visual Studio Code, Tower (Git client), Postman
- Microsoft Edge, Microsoft Teams, Slack
- Figma, Miro, ChatGPT, DevUtils
- Stats, Time Out, Hidden Bar, Bezel

**Fonts:**

- font-fira-code, font-hack-nerd-font, font-ibm-plex-mono

## Important Conventions

### File Organization

- **Symlinks:** Configuration files are symlinked from `~/.dotfiles` to home directory
- **Local overrides:** Use `*_local` files for machine-specific settings (e.g., `.gitconfig_local`)
- **Sensitive data:** Never commit passwords, API keys, or personal identifiers

### Installation Flow

1. Install Homebrew (if not present)
2. Install Ansible
3. Run Ansible playbooks via `install.sh`
4. Symlink dotfiles to home directory
5. Install applications via Homebrew and Mac App Store
6. Configure system preferences

### Symlinks Strategy

Configuration files are symlinked from `~/.dotfiles` to their expected locations:

- `~/.zshrc` → `~/.dotfiles/zsh/.zshrc`
- `~/.gitconfig` → `~/.dotfiles/git/.gitconfig`
- `~/.vimrc` → `~/.dotfiles/vim/.vimrc`
- `~/.config/aliases.sh` → `~/.dotfiles/bash/aliases.sh`

### Local Overrides (Not Tracked)

Use `*_local` files for machine-specific settings:

- `~/.config/local/.gitconfig_local` - Git user name/email
- `~/.config/local/local.sh` - Secret env vars, API keys
- Template: `local/local.sh` (copied, not symlinked)

### Sensitive Data (Never Commit)

- SSH private keys
- Passwords, API keys, tokens
- Personal email addresses
- Licensed fonts (e.g., MonoLisa)
- `.DS_Store` files, `.vscode` settings, `*.log` files

## Ansible Playbook Execution Order

The main playbook (`ansible/playbooks/main.yml`) executes in this order:

1. **Prompt user to continue** (with pause)
2. **symlink-dotfiles.yml** - Create symlinks for config files
3. **install-git.yml** - Install git and link config
4. **install-zsh.yml** - Install zsh and link .zshrc/.zprofile
5. **install-oh-my-zsh.yml** - Install oh-my-zsh framework
6. **install-powerlevel10k.yml** - Install powerlevel10k theme
7. **install-homebrew-packages.yml** - Install all Homebrew packages/apps
8. **install-mac-app-store-apps.yml** - Install Mac App Store apps (macOS only)
9. **install-fonts.yml** - Install fonts from resources/fonts/
10. **configure-ssh.yml** - Set up SSH config and keys
11. **configure-vim.yml** - Configure Vim/Neovim
12. **configure-tmux.yml** - Configure tmux
13. **configure-todo.yml** - Configure todo.txt
14. **configure-finder.yml** - Set Finder preferences (macOS only)
15. **copy-files.yml** - Copy scripts and other files
16. **Prompt user to reboot** (optional)

## Installation & Update Workflow

### Installation Flow

```bash
cd ~/.dotfiles
./install.sh
```

**install.sh does:**

1. Detect OS (Darwin/macOS)
2. Install Homebrew (if not present)
3. Add Homebrew to PATH in `.zprofile`
4. Opt-out of Homebrew analytics
5. Install sshpass (for Ansible)
6. Install Ansible
7. Install `community.general` collection
8. Run `ansible-playbook ansible/playbooks/main.yml`

### Update Flow

```bash
cd ~/.dotfiles
./update.sh
```

**update.sh does:** `git pull` + `./install.sh`

### macOS Preferences Configuration

```bash
./configure-macos-preferences.sh
```

Configures system preferences via `defaults` command for:

- Dock, Finder, Keyboard, Trackpad, Screensaver
- Transmission, Tower Git Client
- Requires restart to apply all changes

## Testing & Quality Assurance

### Pre-commit Hooks

The repository uses pre-commit hooks to enforce quality standards:

- **check-added-large-files:** Prevent large file commits
- **check-merge-conflict:** Detect merge conflict markers
- **check-yaml:** Validate YAML syntax
- **detect-private-key:** Prevent private key commits
- **end-of-file-fixer:** Ensure files end with newline
- **pretty-format-json:** Format JSON files (except terminal themes)
- **trailing-whitespace:** Remove trailing whitespace
- **ansible-lint:** Lint Ansible playbooks
- **actionlint:** Lint GitHub Actions workflows
- **yamllint:** Lint YAML files
- **shellcheck:** Lint shell scripts

### CI/CD

- **GitHub Actions:** Automated ansible-lint workflow (`.github/workflows/ansible-lint.yml`)

## Common Tasks & Workflows

### Adding New Configuration File

1. Place file in appropriate directory (e.g., `vim/`, `zsh/`)
2. Add symlink task in `ansible/playbooks/symlink-dotfiles.yml`:
   ```yaml
   - name: Symlink <filename> to home directory
     ansible.builtin.file:
       src: "{{ playbook_dir }}/../../<dir>/<filename>"
       dest: "$HOME/.<filename>"
       state: link
       force: true
   ```
3. Test: `./install.sh`
4. Run pre-commit: `pre-commit run --all-files`

### Adding New Software

**Homebrew CLI tool:**

- Add to `homebrew_global_packages` or `homebrew_user_packages` in `ansible/vars/main.yml`
- Run: `./update.sh`

**Homebrew cask app:**

- Add to `homebrew_cask_apps` in `ansible/vars/main.yml`
- Run: `./update.sh`

**Mac App Store app:**

- Find app ID: `mas search <app-name>`
- Add ID to `homebrew_mas_apps` in `ansible/vars/main.yml`
- Run: `./update.sh`

**Font:**

- Copy font files to `resources/fonts/`
- Run: `./install.sh` (fonts task will install to system)

### Modifying Ansible Playbooks

- Use fully qualified module names: `ansible.builtin.file`, `community.general.homebrew`
- Set `changed_when: false` for read-only command tasks
- Use `creates:` or `removes:` for command idempotency
- Test playbook: `ansible-playbook ansible/playbooks/<playbook>.yml`
- Lint before committing: `ansible-lint ansible/playbooks/<playbook>.yml`

### Adding Shell Aliases

1. Edit `shell/aliases.sh`
2. Follow pattern: `alias <name>="<command>"`
3. Test: `source ~/.zshrc` or `reload` alias
4. No need to run `install.sh` (file is symlinked)

### Adding Shell Functions

1. Create function in `shell/functions/<name>.sh`
2. Source in `.zshrc`: `source "$HOME/.dotfiles/shell/functions/<name>.sh"`
3. Test: `source ~/.zshrc`

## Security Considerations

- **Never commit:** Passwords, API keys, SSH private keys, personal email addresses
- **Use local files:** Store sensitive configuration in `*_local` files
- **Pre-commit hooks:** Detect private keys automatically
- **SSH keys:** Template only, actual keys managed separately
- **Git user info:** Must be set in `~/.gitconfig_local` (not tracked)

## macOS-Specific Notes

- **Apple Silicon vs Intel:** Install script handles both architectures
- **Homebrew paths:**
  - Apple Silicon: `/opt/homebrew`
  - Intel: `/usr/local`
- **System permissions:** Terminal requires App Management permission for some operations
- **Manual steps:** Some preferences (FileVault, Firewall, Time Machine) cannot be automated

## Troubleshooting Guide

### Common Issues

**"couldn't resolve module/action 'community.general.homebrew'"**

- **Cause:** Ansible collection not installed or not in path
- **Solution:**
  ```bash
  ansible-galaxy collection install community.general --force
  ```

**"Permission denied" errors**

- **Cause:** Terminal lacks App Management permission
- **Solution:** System Preferences → Privacy & Security → App Management → Add Terminal

**Homebrew not in PATH**

- **Cause:** `.zprofile` not sourced
- **Solution:** `source ~/.zprofile` or restart terminal

**Symlink conflicts**

- **Cause:** Existing file at symlink destination
- **Solution:** Ansible playbooks use `force: true` to overwrite
- **Manual:** `rm <existing-file>` then run `./install.sh`

**zsh plugins not working**

- **Cause:** oh-my-zsh not installed or plugins not cloned
- **Solution:** Run `./install.sh` to reinstall oh-my-zsh

**Git commit fails with "no user configured"**

- **Cause:** Missing `~/.config/local/.gitconfig_local`
- **Solution:** Create file with:
  ```ini
  [user]
    name = Your Name
    email = your.email@example.com
  ```

**Mac App Store app install fails**

- **Cause:** App not purchased or not signed in to App Store
- **Solution:** Purchase app or sign in, then retry

## When Suggesting Changes

1. **Minimize modifications:** Only change what's necessary
2. **Follow existing patterns:** Match the style of surrounding code
3. **Test idempotency:** Ensure Ansible tasks can run multiple times safely
4. **Update documentation:** If adding features, update README.md
5. **Run linters:** Ensure changes pass shellcheck, ansible-lint, yamllint
6. **Consider compatibility:** Changes should work on both Apple Silicon and Intel Macs
7. **Preserve working code:** Don't modify unrelated functionality
8. **Security first:** Never suggest committing sensitive data

## Manual Post-Installation Steps

These cannot be automated and must be done manually:

### System Preferences

- Enable FileVault (full disk encryption)
- Enable macOS Firewall
- Set up Time Machine backups
- Allow Apple Watch to unlock Mac

### Application Installations

- Install Little Snitch Network Filter (requires license)
- Install Xcode via `xcodes install <version>`
- Install SwiftLint: `brew install swiftlint` (requires Xcode)
- Install Microsoft Office suite
- Install GarageBand, iMovie, Final Cut Pro, Logic Pro

### Account Setup

- Log in to iCloud
- Add Internet Accounts (Gmail, Microsoft, etc.)
- Authorize Music app for Apple Music
- Sign in to GitHub in Xcode and VS Code
- Activate licenses: Little Snitch, Tower, VMWare, CrossOver

### Application Configuration

- Import Dark.terminal theme in Terminal → Settings → Profiles
- Configure Safari profiles and extensions
- Configure Xcode preferences and download simulators
- Sign in to VS Code with GitHub (Settings Sync)
- Log in to Slack, Teams, Postman, Figma, etc.

## Environment Variables

Key environment variables set in `.zshrc`:

```bash
LANG=en_US.UTF-8              # UTF-8 encoding
EDITOR=vim                     # Default editor
COLORTERM=1                    # Enable colors
HOMEBREW_NO_ENV_HINTS=1       # Disable Homebrew hints
TODOTXT_DEFAULT_ACTION=ls     # Default todo.txt action
BASH_SILENCE_DEPRECATION_WARNING=1  # Hide zsh migration warning
MANPAGER='less -X'            # Don't clear screen after man pages
```

## Shell Aliases (Most Used)

**System:**

- `reload` - Reload .zshrc
- `dotfiles` - cd to ~/.dotfiles

**Git:**

- `g`, `gs`, `gst` - git status
- `gc`, `gcm`, `commit` - git commit
- `push`, `pull` - git push/pull
- `glog` - git log --graph --all

**Navigation:**

- `ll` - ls -lAh with colors
- `..`, `...` - cd up one/two levels
- `dev` - cd ~/Developer
- `scripts` - cd ~/scripts

**Tasks:**

- `t`, `todo` - todo.sh
- `task` - todo.sh add
- `tasks`, `todos` - todo.sh list
- `did`, `done` - todo.sh done

## Architecture & OS Compatibility

### macOS Architecture Detection

The `install.sh` script detects Apple Silicon vs Intel:

```bash
if [[ $(uname -m) == 'arm64' ]]; then
  # Apple Silicon - Homebrew at /opt/homebrew
else
  # Intel - Homebrew at /usr/local
fi
```

### PATH Configuration

- **Apple Silicon:** `/opt/homebrew/bin` added to PATH in `.zprofile`
- **Intel Mac:** `/usr/local/bin` added to PATH in `.zprofile`
- **Custom scripts:** `$HOME/scripts` and `$HOME/bin` added to PATH

## When Suggesting Changes

### Principles

1. **Minimize modifications** - Only change what's necessary
2. **Follow existing patterns** - Match surrounding code style
3. **Test idempotency** - Ensure Ansible tasks can run multiple times safely
4. **Update documentation** - Update README.md for new features
5. **Run linters** - Pass shellcheck, ansible-lint, yamllint before committing
6. **Consider compatibility** - Work on both Apple Silicon and Intel Macs
7. **Preserve working code** - Don't modify unrelated functionality
8. **Security first** - Never suggest committing sensitive data

### Code Review Checklist

- [ ] Follows .editorconfig settings (spaces, line endings)
- [ ] Passes shellcheck (for .sh files)
- [ ] Passes yamllint and ansible-lint (for .yml files)
- [ ] Uses fully qualified Ansible module names
- [ ] Sets `changed_when` appropriately for command tasks
- [ ] Quotes all shell variables
- [ ] Uses `set -e` in shell scripts
- [ ] No hardcoded personal information
- [ ] No sensitive data (keys, passwords)
- [ ] Compatible with both Apple Silicon and Intel
- [ ] Documentation updated if needed

### Common Patterns

**Ansible symlink task:**

```yaml
- name: Symlink <file> to <destination>
  ansible.builtin.file:
    src: "{{ playbook_dir }}/../../<source-dir>/<file>"
    dest: "$HOME/<destination>"
    state: link
    force: true
```

**Ansible command with idempotency:**

```yaml
- name: Create directory if not exists
  ansible.builtin.command: mkdir -p /path/to/dir
  args:
    creates: /path/to/dir
  changed_when: false
```

**Homebrew installation:**

```yaml
- name: Install <package>
  community.general.homebrew:
    name: <package>
    state: present
```

**Shell script header:**

```bash
#!/bin/sh

# Stop on first error
set -e

# Script description here
```

## Repository Statistics

- **Total Ansible playbooks:** 15 files (~532 lines)
- **Shell scripts:** ~2,833 shell script files/lines
- **Configuration domains:** 10+ (zsh, bash, git, vim, tmux, ssh, todo, terminal, xcode, resources)
- **Homebrew packages:** ~30 global, ~10 user-specific
- **Homebrew cask apps:** ~20 applications
- **Mac App Store apps:** ~15 applications
- **Shell aliases:** 55+ custom aliases
- **Git aliases:** 10+ custom aliases

## Additional Context

- **Installation is idempotent** - Can run `install.sh` multiple times safely
- **Fork-friendly** - Others can fork and customize for their needs
- **Personal preferences** - Configurations reflect one person's workflow
- **Manual steps required** - Some configurations cannot be automated (documented in README)
- **Active maintenance** - Pre-commit hooks and CI ensure quality
- **macOS-focused** - Primarily designed for macOS, not Linux/Windows

## Useful Commands

```bash
# Full installation
cd ~/.dotfiles && ./install.sh

# Update dotfiles
cd ~/.dotfiles && ./update.sh

# Configure macOS preferences
cd ~/.dotfiles && ./configure-macos-preferences.sh

# Run pre-commit checks
pre-commit run --all-files

# Test specific Ansible playbook
ansible-playbook ansible/playbooks/<playbook>.yml

# List Homebrew packages
brew list

# Search Mac App Store
mas search <app-name>

# Reload shell configuration
source ~/.zshrc
# or
reload

# View installed oh-my-zsh plugins
ls ~/.oh-my-zsh/custom/plugins/

# Check Ansible syntax
ansible-playbook --syntax-check ansible/playbooks/main.yml
```

---

**Last Updated:** 2025-12-28
**Ansible Version:** 2.x
**oh-my-zsh Version:** Latest stable
**Homebrew Version:** Latest stable
