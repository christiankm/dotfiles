# GitHub Copilot Instructions for dotfiles

## Repository Overview

This is a personal dotfiles repository that manages configuration files and automated setup scripts for macOS systems. The repository uses **Ansible** as the primary automation tool to ensure idempotent installations and configurations.

**Key characteristics:**
- Primary OS: macOS (Darwin)
- Automation: Ansible playbooks
- Package management: Homebrew, Mac App Store
- Shell: zsh with oh-my-zsh and powerlevel10k theme
- Configuration approach: Symlink dotfiles from `~/.dotfiles` to home directory

## Project Structure

```
.
├── ansible/                 # Ansible playbooks and configuration
│   ├── playbooks/          # Individual installation/configuration playbooks
│   └── vars/               # Ansible variables
├── bash/                   # Bash configuration (aliases, functions)
├── git/                    # Git configuration files
├── ssh/                    # SSH configuration templates
├── terminal/               # Terminal themes and configuration
├── tmux/                   # tmux configuration
├── todo/                   # todo.txt configuration
├── vim/                    # Vim configuration and plugins
├── xcode/                  # Xcode themes and settings
├── zsh/                    # zsh configuration (.zshrc, .p10k.zsh)
├── scripts/                # Utility scripts
├── install.sh              # Main installation script
├── update.sh               # Update script
└── configure-macos-preferences.sh  # macOS system preferences
```

## Code Style and Standards

### Shell Scripts
- **Shell dialect:** bash
- **Indentation:** 4 spaces
- **Line endings:** LF (Unix)
- **Linting:** shellcheck with all optional checks enabled
- **Style conventions:**
  - Use `set -e` to stop on errors
  - Use explicit error handling
  - Add comments for complex logic only
  - Quote all variables to prevent word splitting

### YAML Files (Ansible/Workflows)
- **Indentation:** 2 spaces
- **Line endings:** LF (Unix)
- **Linting:** yamllint, ansible-lint (moderate profile)
- **Naming conventions:**
  - Use snake_case for variable names: `^[a-z_][a-z0-9_]*$`
  - Task names prefixed with file stem
  - Loop variables must be prefixed with `__` or role name
- **Ansible best practices:**
  - Use fully qualified collection names (e.g., `ansible.builtin.copy`)
  - Set `changed_when` appropriately to avoid false positives
  - Maximum block depth: 20
  - Use `gather_facts: true` when needed, `false` otherwise

### Markdown Files
- **Line endings:** LF (Unix)
- **Trailing whitespace:** Preserved (not trimmed)

### General
- **Encoding:** UTF-8
- **Final newline:** Always insert
- **Trailing whitespace:** Trim (except Markdown)

## Key Technologies

### Automation & Configuration
- **Ansible:** Primary automation tool
  - Community.general collection required
  - Playbooks located in `ansible/playbooks/`
  - Main entry point: `ansible/playbooks/main.yml`
- **Homebrew:** Package manager for macOS
  - Used to install CLI tools and GUI applications
  - Analytics disabled by default

### Shell Environment
- **zsh:** Default shell
- **oh-my-zsh:** zsh framework
- **powerlevel10k:** Theme for zsh

### Development Tools
- **Git:** Version control with custom global config
  - Local user config: `~/.gitconfig_local` (not checked in)
  - Global ignores: `.gitignore_global`
- **Vim:** Text editor with custom configuration
  - Plugins managed manually
  - Custom markdown checkbox concealment
- **tmux:** Terminal multiplexer

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

### Ansible Playbook Order
Playbooks are executed in this order (see `ansible/playbooks/main.yml`):
1. Symlink dotfiles
2. Install git, zsh, oh-my-zsh, powerlevel10k
3. Install Homebrew packages and Mac App Store apps
4. Install fonts
5. Configure SSH, vim, tmux, todo.txt
6. Configure Finder and macOS preferences
7. Copy files and scripts

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

## Common Tasks

### Adding New Configuration
1. Place configuration file in appropriate directory (e.g., `vim/`, `zsh/`)
2. Add symlink task in `ansible/playbooks/symlink-dotfiles.yml`
3. Test with `./install.sh`
4. Run pre-commit hooks: `pre-commit run --all-files`

### Adding New Software
1. Add to `ansible/playbooks/install-homebrew-packages.yml` for CLI tools
2. Add to `ansible/playbooks/install-mac-app-store-apps.yml` for Mac App Store apps
3. Document manual installation steps in README if not automatable

### Modifying Ansible Playbooks
- Use `community.general.homebrew` for package management
- Always set `changed_when` for command tasks that don't change state
- Test playbook: `ansible-playbook ansible/playbooks/<playbook>.yml`
- Lint before committing: `ansible-lint ansible/playbooks/<playbook>.yml`

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

## Troubleshooting Guidelines

### Common Issues
1. **"couldn't resolve module/action 'community.general.homebrew'"**
   - Solution: `ansible-galaxy collection install community.general --force`

2. **Permission denied errors**
   - Check: Terminal has App Management permission in System Preferences
   - Run: `sudo -v` to refresh sudo credentials

3. **Homebrew not in PATH**
   - Solution: Source `~/.zprofile` or restart terminal

## When Suggesting Changes

1. **Minimize modifications:** Only change what's necessary
2. **Follow existing patterns:** Match the style of surrounding code
3. **Test idempotency:** Ensure Ansible tasks can run multiple times safely
4. **Update documentation:** If adding features, update README.md
5. **Run linters:** Ensure changes pass shellcheck, ansible-lint, yamllint
6. **Consider compatibility:** Changes should work on both Apple Silicon and Intel Macs
7. **Preserve working code:** Don't modify unrelated functionality
8. **Security first:** Never suggest committing sensitive data

## Additional Context

- **Installation is idempotent:** Can run `install.sh` multiple times safely
- **Manual steps required:** Some configurations cannot be automated (documented in README)
- **Personal repo:** Configurations reflect one person's preferences
- **Fork-friendly:** Others can fork and customize for their needs
