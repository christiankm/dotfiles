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

## development

- [ ] set up fedora C/swift dev workspace on Blackbird
- [ ] set up/restore Betwell windows workspace VM on Blackbird, develop inside vm over remote desktop
- [x] simplify and eliminate unnessary vs code plugins

## desktop and configuration

- [ ] install `dockutil` to configure macOS Dock items
- [ ] install `mysides` to configure macOS Finder items

## macOS configuration

- configure system preferences from playbook/script:
  - Dock: 
    - [ ]minimize windows to app icon
  - Display:
    - [ ] enable Stage Manager
    - [ ] disable 'show recent apps in Stage Manager'
    - [ ] enable true tone
    - [ ] enable night shift, sunset to sunrise
- [x] remove animation when switching between spaces
    NOTE: trialing 'Reduce Motion' to use a fade animation instead, though also affects Stage Manager and other things

## magnet/window manager config

## neovim

- [ ] brug rose pine theme
- [x] find plugin for vim md todo lists to check off, auto-add checkbox on new line, etc.
- [x] lower line length so wrapping happens before line 80

## tmux

- [ ] brug rose pine theme
- [x] restore previous session and layout on reboots/quit
  use current folder name
- [x] new panels (when splitting) opens in the same directory as current

## tools to try

- [ ] yabai window tiling manager (https://github.com/asmvik/yabai)
- [ ] Karabiner elements (https://karabiner-elements.pqrs.org)
