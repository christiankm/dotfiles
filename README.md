# dotfiles

This is a collection of my personal dotfiles (configuration files and install scripts) used to setup my computers and servers.

## Installation

I keep this repo in `~/.dotfiles` and symlink the files and directories inside.
This happens automatically when running the `bootstrap.sh` script, which will interactively configure everything.

On any new computer (Linux, macOS or Windows), all I need to do is open the default terminal and run:

```
git clone https://github.com/christiankm/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Uninstall

To uninstall software and remove files and symlinks, run:

`~/.dotfiles/unlink.sh`

Then restart your terminal.
