#!/bin/sh

# This script will install all required software, packages and tools on a new machine, to my liking.
# It will configure them as needed, and setup all program configurations and settings.
# This script can be run on any machine, on any OS, and should act accordingly.

set -e # stop on first error

# Ask for the administrator password upfront
sudo -v -u $(whoami)

success() {
  printf "\r\033[2K[\033[00;32mOK\033[0m] %s\n" "$1"
}

DOTFILES=$(pwd)

# Detect OS
printf "Detected operating system: "
case "$OSTYPE" in
  solaris*) echo "Solaris" ;;
  darwin*)  echo "macOS" ;; 
  linux*)   echo "Linux" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "Windows" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

# Set environment variables
if [[ "$OSTYPE" =~ ^darwin ]]; then
  HOME=/Users/$(whoami)
fi

# Install package managers

# Install Homebrew, if macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    if [[ $(uname -m) == 'arm64' ]]; then
      # for Apple Sillicon Mac
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      # for Intel Mac
      (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> $HOME/.zprofile
      eval "$(/usr/local/bin/brew shellenv)"
    fi

    source $HOME/.zprofile

    success "Homebrew installed to $(which brew)"
  fi
  
  # Opt-out of Homebrew analytics
  echo "Disabling Homebrew analytics..."
  export HOMEBREW_NO_ANALYTICS=1
  brew analytics off

  # Install sshpass
  if [[ $(command -v sshpass) == "" ]]; then
    brew tap esolitos/ipa
    brew install esolitos/ipa/sshpass
  fi

  # Install Ansible
  if [[ $(command -v ansible) == "" ]]; then
    brew install ansible
  fi
fi

ln -sf "$(pwd)/.zshrc" $HOME/.zshrc

# Run Ansible
export ANSIBLE_CONFIG=./ansible/ansible.cfg
ansible-playbook \
  ./ansible/playbooks/main.yml \
  -c local \
  -i ./ansible/inventory/hosts

# Cleanup
rm -rf $HOME/.zcompdump*
rm -rf $HOME/.zshrc.pre-oh-my-*

# Reload new settings
source $HOME/.zshrc

success "All done. Please reboot computer to make all changes take effect"
