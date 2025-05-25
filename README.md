# dotfiles

This is a collection of my personal dotfiles (configuration files and install scripts) used to setup my computers and servers.

## Installation

I keep this repo in `~/.dotfiles` and symlink the files and directories inside.
This happens automatically when running the `install.sh` script, which will interactively configure everything.

On any new computer (Linux, macOS or Windows), all I need to do is open the default terminal and run:

```bash
git clone https://github.com/christiankm/dotfiles.git ~/.dotfiles
```

Before proceeding, edit and configure the relevant Ansible playbooks to install
and configure only the programs and settings you need. You may also comment out
any playbooks that you do not need in `ansible/playbooks/main.yml`.

When ready, we can now go ahead and start the installation process:

```bash
cd ~/.dotfiles
./install.sh
```

## Run with Ansible

`$ ansible-playbook ./ansible/playbooks/main.yml -i ./ansible/inventory/hosts.ini`

## Troubleshooting

On a new machine, some commands may fail or not work as expected due to certain preconditions (or lack of handling in the scripts). Here is a collection of problems I've run into in the past and how to fix them.

### couldn't resolve module/action 'community.general.homebrew

This error may appear if the script fails to install the community packages correctly or the environment is unable to locate them.

Double-check that the packages were installed in `~/.ansible/collections/ansible_collections/community/general`. If not installed, install manually by running the following command, and then retry running the `install.sh` script:

```bash
$ ansible-galaxy collection install community.general --force
```


