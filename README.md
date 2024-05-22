# dotfiles

This is a collection of my personal dotfiles (configuration files and install scripts) used to setup my computers and servers.

## Installation

I keep this repo in `~/.dotfiles` and symlink the files and directories inside.
This happens automatically when running the `install.sh` script, which will interactively configure everything.

On any new computer (Linux, macOS or Windows), all I need to do is open the default terminal and run:

```bash
git clone https://github.com/christiankm/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Run with Ansible

`$ ansible-playbook ./ansible/playbooks/main.yml -i ./ansible/inventory/hosts.ini`

## Uninstall

To uninstall software and remove files and symlinks, run:

```bash
~/dotfiles/uninstall.sh
```

Then restart your terminal.
