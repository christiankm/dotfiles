# dotfiles

## general

- [ ] fix ansible-lint failing/errors
- [ ] change vim conceal task to be a large circle
- [ ] use ~/.config to store all config files instead of home folder (XDG_CONFIG)
- [ ] create alias '??' for doing a quick ChatGPT/Claude prompt question, i.e. '$ ?? what is pi'

## scripts and aliases

- [ ] script/alias to quit an app by name (find pid, kill)
- [ ] create bash function `archive()` taking a file/directory path as `$1` and moves to `$HOME/archive`, creating the archive folder if not exists. Moves to `./archive` instead if that exists
- [ ] create bash function `completed()` taking a file/directory path as `$1` and moves to `./completed/`, creating the folder if not exists. Useful for completing task/project files

## desktop and configuration

- [ ] install `dockutil` to configure macOS Dock items
- [ ] install `mysides` to configure macOS Finder items

## macOS configuration

- configure system preferences from playbook/script:
  - Dock:
    - [ ] minimize windows to app icon
  - Display:
    - [ ] enable Stage Manager
    - [ ] disable 'show recent apps in Stage Manager'
    - [ ] enable true tone
    - [ ] enable night shift, sunset to sunrise
- [x] remove animation when switching between spaces
    NOTE: trialing 'Reduce Motion' to use a fade animation instead, though also affects Stage Manager and other things
