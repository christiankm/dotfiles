#!/bin/sh

# Stop on first error
set -e

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

# Install Ansible prerequisites

if [[ "$OSTYPE" =~ ^darwin ]]; then
  # Install Homebrew, if macOS
  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    if [[ $(uname -m) == 'arm64' ]]; then
      # Apple Sillicon Mac
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      # Intel Mac
      (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> $HOME/.zprofile
      eval "$(/usr/local/bin/brew shellenv)"
    fi

    source $HOME/.zprofile

    echo "Homebrew installed to $(which brew)"
  fi

  # Opt-out of Homebrew analytics
  echo "Disabling Homebrew analytics..."
  export HOMEBREW_NO_ANALYTICS=1
  brew analytics off

  # Install sshpass
  if [[ $(command -v sshpass) == "" ]]; then
    echo "Installing sshpass..."
    brew tap esolitos/ipa
    brew install esolitos/ipa/sshpass
  fi

  # Install Ansible and required collections
  if [[ $(command -v ansible) == "" ]]; then
    echo "Installing Ansible..."
    brew install ansible
    ansible-galaxy collection install community.general
  fi
fi

# Run Ansible
echo "Running Ansible playbooks..."
export ANSIBLE_CONFIG=./ansible/ansible.cfg
ansible-playbook \
  ./ansible/playbooks/main.yml \
  -i ./ansible/inventory/hosts.ini

success "Installation completed. Reboot your machine now for all changes to take effect"
