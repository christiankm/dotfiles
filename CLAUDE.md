# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS, using Ansible for idempotent automation. Repo lives at `~/.dotfiles`; config files are symlinked to their expected locations in `$HOME`.

## Commands

```bash
# Full installation (idempotent — safe to re-run)
./install.sh

# Pull latest + reinstall
./update.sh

# Apply macOS system preferences via defaults
./configure-macos-preferences.sh

# Run a single Ansible playbook
ansible-playbook ansible/playbooks/<playbook>.yml

# Lint everything before committing
pre-commit run --all-files

# Lint individual file types
shellcheck <script.sh>
ansible-lint ansible/playbooks/<playbook>.yml
yamllint <file.yml>
```

## Architecture

### Directory Layout

- `ansible/playbooks/` — One playbook per concern; `main.yml` is the entry point
- `ansible/vars/main.yml` — All package lists (Homebrew, casks, MAS apps)
- `ansible/tasks/` — Reusable task files imported by playbooks
- `bash/aliases.sh` — 55+ shell aliases (symlinked to `~/.config/aliases.sh`)
- `bash/functions/` — Shell functions sourced individually in `.zshrc`
- `zsh/` — `.zshrc`, `.zprofile`, `.p10k.zsh`
- `git/` — `.gitconfig` (includes `~/.config/local/.gitconfig_local`), `.gitignore_global`, commit template
- `vim/` — `.vimrc`, plugins, after-load scripts
- `bin/` — User scripts added to `$PATH`
- `local/` — Machine-specific files (not tracked; copied, not symlinked)
- `resources/fonts/` — Fonts installed to system by Ansible

### Playbook Execution Order (`main.yml`)

1. symlink-dotfiles → install-git → install-zsh → install-oh-my-zsh → install-powerlevel10k
2. install-homebrew-packages → install-mac-app-store-apps → install-fonts
3. configure-ssh → configure-vim → configure-tmux → configure-todo → configure-finder
4. copy-files

### Symlink Strategy

Ansible symlinks files from `~/.dotfiles` into `$HOME`. Always use `force: true` and fully qualified module names:

```yaml
- name: symlink-dotfiles | Symlink <file>
  ansible.builtin.file:
    src: "{{ playbook_dir }}/../../<dir>/<file>"
    dest: "$HOME/<destination>"
    state: link
    force: true
```

### Local Overrides (Never Committed)

- `~/.config/local/.gitconfig_local` — Git user name/email (required)
- `~/.config/local/local.sh` — Machine-specific env vars, API keys
- Template at `local/local.sh` (copied, not symlinked)

## Code Standards

### Shell Scripts

- Dialect: `sh` (shebang `#!/bin/sh`), with `set -e`
- Indentation: 4 spaces
- Use `[[ ]]`, `$(...)`, quote all variables
- Disabled shellcheck rules: SC1091, SC2250, SC2086, SC2139, SC2292, SC2155, SC2312, SC2034, SC2230

### YAML / Ansible

- Indentation: 2 spaces, max line length 100
- Use fully qualified module names: `ansible.builtin.*`, `community.general.*`
- Task names prefixed with `{playbook-stem} |` (e.g., `symlink-dotfiles | Symlink .zshrc`)
- Set `changed_when: false` for read-only commands; use `creates:`/`removes:` for idempotency
- Variables: snake_case (`^[a-z_][a-z0-9_]*$`)

### Adding Packages

Edit `ansible/vars/main.yml` and add to the appropriate list:

- `homebrew_global_packages` — CLI tools for all machines
- `homebrew_user_packages` — Machine-specific CLI tools
- `homebrew_cask_apps` — GUI applications
- `homebrew_mas_apps` — Mac App Store apps (find ID with `mas search <name>`)

Then run `./update.sh`.

## CI

GitHub Actions runs `ansible-lint` on push/PR (`.github/workflows/ansible-lint.yml`). Pre-commit hooks enforce shellcheck, yamllint, ansible-lint, actionlint, and key hygiene checks locally.
