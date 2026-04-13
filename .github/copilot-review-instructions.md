# Copilot Code Review Instructions

Instructions for GitHub Copilot when reviewing pull requests in this repository.

## Repository Context

This is a personal dotfiles repository for macOS configuration and development
environment automation. Changes here directly affect system setup and installed
tooling, so correctness and idempotency matter.

## Review Priorities

### Security (Critical)

- Flag any hardcoded secrets, passwords, API keys, tokens, or personal
  identifiers (email addresses, usernames, private SSH keys).
- Verify that new symlink targets do not expose sensitive files.
- Check that new shell scripts do not download or execute remote code without
  integrity verification.
- Ensure no private key files (`.pem`, `.key`, `id_rsa`, etc.) are being
  tracked or symlinked.

### Idempotency (High)

- Ansible tasks must be safe to run multiple times without side-effects.
- Use `creates:` / `removes:` guards on `ansible.builtin.command` /
  `ansible.builtin.shell` tasks, or set `changed_when` appropriately.
- Prefer declarative Ansible modules (`ansible.builtin.file`,
  `community.general.homebrew`, etc.) over `command`/`shell` when a module
  exists for the operation.

### Correctness (High)

- Shell scripts must handle errors: every script should have `set -e` (or
  equivalent) and quote all variable expansions.
- Ansible playbooks must use **fully qualified collection names** (e.g.
  `ansible.builtin.file`, `community.general.homebrew`).
- Task names must be prefixed with the playbook stem followed by ` | ` (e.g.
  `symlink-dotfiles | Symlink .zshrc`).
- Loop variables must start with `__` or the role name per `.ansible-lint.yml`.
- Variable names must match `^[a-z_][a-z0-9_]*$` (snake_case only).

### Shell Script Standards

- Dialect: `sh` (shebang `#!/bin/sh`), `set -e` required.
- Indentation: 4 spaces; no tabs.
- Use `[[ ]]` for conditionals, `$(...)` for command substitution.
- Quote all variable references to prevent word-splitting.
- Respect the shellcheck suppressions defined in `.shellcheckrc`; do not add
  new `# shellcheck disable` comments without justification.

### YAML / Ansible Standards

- Indentation: 2 spaces; max line length 100 characters.
- Truthy values: `true`/`false` preferred; `yes`/`no`/`on`/`off` are accepted
  but flag inconsistency within the same file.
- `gather_facts` should only be `true` when facts are actually used.
- New packages added to `ansible/vars/main.yml` should go in the correct list:
  - `homebrew_global_packages` — CLI tools for all machines
  - `homebrew_user_packages` — machine-specific CLI tools
  - `homebrew_cask_apps` — GUI applications
  - `homebrew_mas_apps` — Mac App Store apps (include numeric ID)

### Symlink Tasks

New symlink tasks in `ansible/playbooks/symlink-dotfiles.yml` must use:

```yaml
- name: symlink-dotfiles | Symlink <file>
  ansible.builtin.file:
    src: "{{ playbook_dir }}/../../<dir>/<file>"
    dest: "$HOME/<destination>"
    state: link
    force: true
```

## What to Flag

- Missing `changed_when` on `command`/`shell` tasks.
- Short module names instead of fully qualified ones.
- New `.gitignore` patterns that are too broad or too narrow.
- Changes to `configure-macos-preferences.sh` that use undocumented `defaults`
  keys — suggest verifying on a real macOS system.
- Dependencies added without a corresponding entry in `ansible/vars/main.yml`.
- Workflow files (`.github/workflows/`) that grant excessive permissions or use
  unpinned third-party actions without a SHA pin.

## What Not to Flag

- Auto-generated files (`.p10k.zsh`, fonts, Xcode themes) — these are managed
  externally.
- The `local/` directory — machine-specific files are intentionally not tracked.
- Minor stylistic preferences that are not enforced by the project linters.
