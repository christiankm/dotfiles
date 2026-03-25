# dotfiles

- [ ] fix ansible-lint failing/errors
- [ ] change vim conceal task to be a large circle

## scripts and aliases
- [ ] script/alias to quit an app by name (find pid, kill)
- [ ] create bash function `archive()` taking a file/directory path as `$1` and moves to `$HOME/archive`, creating the archive folder if not exists. Moves to `./archive` instead if that exists
- [ ] create bash function `completed()` taking a file/directory path as `$1` and moves to `./completed/`, creating the folder if not exists. Useful for completing task/project files

## development
- [ ] set up fedora C/swift dev workspace on Blackbird
- [ ] set up/restore Betwell windows workspace VM on Blackbird, develop inside vm over remote desktop
- [x] simplify and eliminate unnessary vs code plugins

## mac config

## magnet/window manager config

## (neo)vim config
- [x] find plugin for vim md todo lists to check off, auto-add checkbox on new line, etc.
- [x] lower line length so wrapping happens before line 80

## tmux config
- [x] restore previous session and layout on reboots/quit
- [ ] auto-rename windows/panes based on repo-name if inside git repo, otherwise
  use current folder name
- [ ] new panels (when splitting) opens in the same directory as current
