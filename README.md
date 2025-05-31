# dotfiles

This is a collection of my personal dotfiles (configuration files and install scripts) used to setup my computers and servers.
I keep this repo in `~/.dotfiles` and symlink the files and directories inside.
This happens automatically when running the `install.sh` script, which will interactively configure everything.

I use Ansible to perform most of the operations to ensure a consistent state. This means I can run the installer as many times as I want, either in case of errors or if I add/remove programs or settings, and it will only change what differs from what is currently installed on the machine.

Please feel free to fork or clone this repository. I would appreciate opening a pull request for any suggestions or tips.

## Prerequisites and recommendations

### Install all operating system updates

It is recommended (unless you have a good reason not to) to install all macOS Software Updates before following these instructions, by opening System Preferences → General → Software Update. You should not configure any other preferences yet, as they may be overridden during the install process.

### Install Git if needed

Depending on your operating system, git may not be installed by default.

On Mac, git may not be installed or active yet, and when trying to clone will prompt you to install the Xcode Command Line Tools using the installer. If no install window appears, you can trigger this by running the following command. After installation has completed, retry cloning the repo.

```bash
xcode-select --install
```

### Configure macOS Security settings

On macOS, some parts of the install may require Terminal to have the App Management permission set in System Preferences. It is advisable to do this before running the installer to prevent errors. Go to System Preferences → Privacy & Security → App Management, and manually add the Terminal application to the list. Enter your password if prompted, then quit System Preferences.

### Clone the dotfiles repository

Open a new Terminal window and clone the GitHub repository:

```bash
git clone git@github.com:christiankm/dotfiles.git ~/.dotfiles
```

NOTE: You may wish to copy/create your SSH keys to the new machine first, and use SSH to clone the repo instead. After installing your SSH key (and adding it to your GitHub account), you can clone the repo.

## Installation

Before proceeding, edit and configure the relevant Ansible playbooks to install
and configure only the programs and settings you need. You may also comment out
any playbooks that you do not need in `ansible/playbooks/main.yml`.

When ready, we can now go ahead and start the installation process:

```bash
cd ~/.dotfiles
./install.sh
```

## Manual steps to complete installation

After this, some manual installation or configuration may be required, which cannot (or is yet) be automated. You might have some applications that are purchsed or cannot be downloaded from Homebrew or the Mac App Store.

If you have a way to automate these, kindly raise a Pull Request with a solution or send me an e-mail.

### Create a `~/.gitconfig_local` file

This dotfiles installation assumes, and imports, your local git config from a separate file to avoid checking in any personal details into git. Global config settings are checked in and linked as `~/.gitconfig` as expected.

This file expects (and imports) the `~/.gitconfig_local` file, which must provide any user config you wish to use on the machine as standard. At the very least, you should create the file with the following contents:

```ini
[user]
  name = Your Name
  email = yourname@example.com
```

If you have a need to use different name and/or e-mail addresses on a specifc repo basis, you can edit the `.git/config` file inside that repo.

### Configure macOS System Preferences

- Enable FileVault
- Enable macOS Firewall
- Enable and set up Time Machine
- Allow Apple Watch to unlock your Mac

### Install additional applications

- Install Little Snitch Network Filter
- Install Tower from the https://gittower.com website
- Install Xcode using `xcodes` command line tool
- Install SwiftLint
  - SwiftLint requires a full installation of Xcode to be present to install, otherwise homebrew installation will fail. Install SwiftLint to the system with `$ brew install swiftlint`.
- Install Microsoft Office
- Install other Mac App Store applications (paid)
  - GarageBand, iMovie, Final Cut Pro, Logic Pro
  - Wipr, DaisyDisk, GrandPerspective, etc.

### Add system accounts

- Log in to iCloud
- Log in to Internet Accounts (e-mail, calendar, contacts, etc.) with Google, Microsoft, etc.
- Authorize Music app to use account (required for Apple Music sync)

## Troubleshooting

On a new machine, some commands may fail or not work as expected due to certain preconditions (or lack of handling in the scripts). Here is a collection of problems I've run into in the past and how to fix them.

### couldn't resolve module/action 'community.general.homebrew

This error may appear if the script fails to install the community packages correctly or the environment is unable to locate them.

Double-check that the packages were installed in `~/.ansible/collections/ansible_collections/community/general`. If not installed, install manually by running the following command, and then retry running the `install.sh` script:

```bash
ansible-galaxy collection install community.general --force
```
