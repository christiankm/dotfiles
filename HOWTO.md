# HOWTO

This is my personal reference for how my machine is set up and how I approach work day to day. It's not meant to document every possible thing — just the stuff I'd want to look up when I've forgotten a keybinding, or when I'm setting up a new machine and trying to remember how I had things organized.

I try to keep things fast and keyboard-driven. Most common actions have an alias or a short keybinding.
The goal is to stay in flow — fewer clicks, fewer trips to the mouse, fewer things to think about.

I do not neccessarily prefer terminal tools over GUI apps. CLI tools tend to be faster and more composable.
I'm using Vim keybindings, and use tmux, neovim, (lazy)git frequently. I'd like to create scripts
or custom programs or functions for common tasks.

## Workflow

I do iOS/Apple platform development (Swift, Obj-C) and C#/.NET backend work. Most of the time I'm split across a couple of active projects at once.

The main environment is a fullscreen terminal running tmux. I keep one session per project/repo, and each session has the same rough window layout so muscle memory transfers across projects:

1. `nvim` — editor, always window 1
2. `lazygit` — git, staging, reviewing changes
3. `build` — fastlane (for iOS) or `dotnet build/run` (for backend); logs go in a split pane at the bottom of this window
4. `claude` — AI assistant running in the terminal
5. `github` — `gh` CLI, PR workflows, issue triage

Switching between iOS and backend work means switching sessions. Sessions persist across reboots (tmux-resurrect), so I never lose the window layout.

---

## Apps and tools

List of key apps and command-line tools that I use, and their purpose.
My primary machine platform is macOS, hence this list is specific to that.
I will occasionally use Windows to access Visual Studio, games, variety of database and Azure tools.

| App | Purpose |
|------|---------|
| Finder |
  Safari
  Calender
  Reminders
  Notes
  Terminal
  Xcode
  Pages
  Numbers
  Keynote
  Magnet
  Velja
  MeetingBar
  VS Code
  Tower
  Postman
  Proxyman
  Markedit
  CotEditor
  iA Writer
  Hidden Bar
  Stats
  Gitify
  Rocket
  Windows App

| Command Line Tool | Purpose |
|------|---------|
| `lazygit` | Terminal UI for git — staging hunks, interactive rebase, history |
| `fzf` | Fuzzy finder, integrated with zsh |
| `rbenv` | Ruby version manager |
| `nvm` | Node.js version manager |
| `pyenv` | Python version manager |
  `git`
  `gh`
  `awk`
  `rg` rip-grep
  `cal`
  `date`
  `man`
  `btop` very visual resource and activity monitor
| `ansible` | Dotfiles automation |
| `shellcheck` | Shell script linting |
| `todo-txt` | Plain-text task management |
| `mas` | Mac App Store CLI |
| `proxyman` | HTTP proxy / network debugger |
| `tower` | Git GUI — for visual history and complex operations |
| `magnet` | Window manager |
| `velja` | Browser/link router |
| `hidden bar` | Menu bar item manager |
 `xcodebuild`
 `xcsimctl`
 `swiftly`
 `swift`
 `publish`
 `brew`
 `neovim`
 `tmux`
 `ansible-lint`
 `swiftlint`
 `swiftformat`
---

## macOS keyboard shortcuts

TABLE
| cmd + Space | Open Spotlight |
| ctrl + cmd + q | Lock screen |
| cmd + shift + <3 or 4 or 5> | Screenshot |
| ctrl + <left or right arrow> | Move between Spaces |
| cmd + m | Minimize app |
| cmd + h | Hide app |
| cmd + option + h | Hide other apps |

## Magnet

TABLE
| ctrl + option + enter | Maximize window |
| ctrl + option + c | Center window |
| ctrl + option + d | Move to Left Third |
| ctrl + option + f | Move to Middle Third |
| ctrl + option + g | Move to Right Third |

## Shell (Zsh)

Theme: **Powerlevel10k**. Plugins: fzf, zsh-autosuggestions, zsh-syntax-highlighting, git, gh, tmux, macos, xcode, swiftpm.

### Standard commands

A list of basic commands to use in shell. I mostly know all these by heart, though it's useful to have a reference as a reminder to what's possible.

TABLE
 `echo "<string>"` prints <string>
 `pipe symbol` pipe output to new command input
 `>` pipe output into file (overwrite)
 `>>` append to bottom of given file
 `clear` clears screen
 `alias` prints all current aliases
 `export` prints all environment variables
 `which <program>` prints path to program
 `cd <dir>` change directory
 `ls` list directory contents


### Navigation and Aliases

| Alias | Command |
|-------|---------|
| `dotfiles` | `cd ~/.dotfiles` |
| `dev` | `cd ~/Developer` |
| `bin` | `cd ~/.local/bin` |
| `scripts` | `cd ~/scripts` |
| `ls` | `ls -CGp` (color + trailing slashes) |
| `ll` | `ls -lAhtGtpc` (long list, sorted by time) |

| Alias | Description |
|-------|-------------|
| `reload` | Reload `~/.zshrc` |
| `vi` | Open Neovim |
| `see` | `cat` |
| `del` | `rm` |
| `rm` | `rm -i` (with confirmation) |
| `cp` | `cp -i` (with confirmation) |

---

## Git

Config: `~/.dotfiles/git/.gitconfig`. Local user identity lives in `~/.config/local/.gitconfig_local` (not committed). Pull is always rebase; fetch prunes deleted remote branches automatically.

For everyday work the shell aliases below handle the common flow. When I need to stage individual hunks or untangle something messy, I drop into lazygit. Tower is there for the rare times I want a full visual history or need to do something I don't trust myself to do on the command line.

TABLE
Command
`git status`
`git add`
`git add -i` interactive git add
`git commit`
`git reset`
`git branch -l`
`git branch <branch name>`
`git stash`
`git pull`
`git push`
`git push --force-with-lease`
`git rebase`
`git diff`
`git log`
`git reflog`
`git clean -f -d`
...

### Aliases

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `gs` / `gst` | `git status` |
| `gc` / `gcm` / `commit` | `git commit` |
| `push` | `git push` |
| `pull` | `git pull --rebase` |
| `prs` | `gh pr list` |
| `glog` | `git log --all --decorate --graph` |

### Git aliases (use as `git <alias>`)

| Alias | Command |
|-------|---------|
| `b` | `branch` |
| `branches` | `branch -l` |
| `co` | `checkout` |
| `sw` | `switch` |
| `c` | `commit` |
| `cn` | `commit --no-verify` |
| `s` | `status` |
| `a` | `add` |
| `pushnew` | `push -u origin HEAD` (push new branch) |

---

## Tmux

Prefix: `Ctrl+b`. Mouse: enabled. Vi keys: enabled. Windows/panes indexed from 1.

One session per project/repo. Each session follows the same window layout — see the Workflow section above. Sessions survive reboots via tmux-resurrect so I never have to rebuild the layout. Switching projects means switching sessions (`Ctrl+b + s`).

### Session management

| Command | Description |
|---------|-------------|
| `tmux new -s <name>` | New named session |
| `tmux ls` / `tl` | List sessions |
| `tmux attach -t <name>` | Attach to session |

### Key bindings

| Key | Action |
|-----|--------|
| `Ctrl+b + r` | Reload tmux config |
| `Ctrl+b + I` | Install plugins |
| `Ctrl+b + K` | Uninstall plugins |
| `Ctrl+b + h/j/k/l` | Navigate panes (left/down/up/right) |
| `Alt+Shift+h` | Previous window |
| `Alt+Shift+l` | Next window |
| `Ctrl+b + c` | New window |
| `Ctrl+b + ,` | Rename window |
| `Ctrl+b + $` | Rename session |
| `Ctrl+b + s` | Browse sessions |
| `Ctrl+b + d` | Detach from session |
| `Ctrl+b + %` | Split pane vertically |
| `Ctrl+b + "` | Split pane horizontally |
| `Ctrl+b + [` | Enter copy mode (vi keys) |
| `Ctrl+b + Ctrl+z` | Open floating shell over current window |

### Plugins

- **tmux-resurrect** — Persist sessions across restarts. `Ctrl+b + Ctrl+s` to save manually, `Ctrl+b + Ctrl+r` to restore.
- **tmux-continuum** — Auto-saves sessions periodically so I don't have to think about it.
- **vim-tmux-navigator** — `Ctrl+h/j/k/l` navigates seamlessly between vim splits and tmux panes.

---

## Neovim (and vim)

I am trying to learn and use neovim as my primary code and text editor, getting comfortable with navigating around files, jumping between files, learning plug-ins, LSPs, learn lua. I am no means religious about neovim (or CLI tools), and will still use (and prefer) GUIs for certain things, such as Xcode for some iOS development, VS Code for some kinds of projects, and Tower as a visual git client.

My config is based and kickstarted (pun indented) with kickstart.nvim and lazy.nvim. I keep it fairly minimal with an amount of customizations that are specific to my preferences and needs.

### Plugins

TABLE


### Preferences

- Startup: running `nvim` (alias `vi`) with no arguments will open current directry in netrw
- Line numbers: hybrid (absolute + relative)
- Indentation: 4 spaces, expandtab
- Color column at 100; soft word wrap at linebreak
- Swap files: disabled

### Key mappings

| Key | Action |
|-----|--------|
| `,` | Leader key |
| `Ctrl+h/j/k/l` | Navigate between tmux/vim panes (vim-tmux-navigator) |

---

## Task Management (todo.txt)

Plain text, fast, no app required. Running `today` at the start of a session shows the calendar and task list together.

| Alias | Action |
|-------|--------|
| `today` | Show calendar + task list |
| `task <text>` | Add a task |
| `tasks` / `todos` | List all tasks |
| `did <n>` | Start task number n |
| `done <n>` | Complete task number n |
| `due` | List tasks with due dates |
| `report` | Show completion report |
| `t` | Full `todo.sh` command |

---

## Xcode and Simulators: iOS / Swift Development

| Keyboard Shortcut | Description |
|-------------------|-------------|
| cmd + b | Build |
| cmd + r | Run |
| shift + cmd + u | Build for testing |
| cmd + u | Test
| cmd + . (period) | Stop |
| ctrl + option + g | Test last run again |
| cmd + mouse click | Jump to definition |
| option + mouse click | Show documentation |

| Alias | Description |
|-------|-------------|
 `xcodebuild`
 `xcrun simctl`
 `xcrun simcrl erase all` Erases all simulators contents
| `fl [ios build]` | alias to `bundle exec fastlane`, for quickly running fastlane lanes |
| `delder` | Delete Xcode DerivedData directory |

---

## macOS Preferences

Applied by `./configure-macos-preferences.sh`. These are the non-obvious ones worth knowing about:

- **Keyboard**: Fast key repeat, short initial delay — makes navigating in vi feel much more responsive
- **Trackpad**: Tap-to-click on, 3-finger drag enabled, press-and-hold disabled (so key repeat works)
- **Dock**: 46px icons, no magnification, scale minimize effect
- **Finder**: List view default, path bar visible, hide extensions
- **Screensaver**: 2 minutes idle
- **System**: Auto dark mode, 1-hour standby delay

---
