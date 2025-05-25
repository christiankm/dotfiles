#!/bin/sh

# Stop on first error
set -e

# Ask for administrator password
sudo --askpass --bell --validate -u $(whoami) --prompt 'Enter sudo password for $(whoami): '

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
  DOTFILES=$(pwd)
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

    export ANSIBLE_CONFIG=./ansible/ansible.cfg
    ansible-galaxy collection install community.general --force
  fi
fi

# Run Ansible
ANSIBLE_USER=$(whoami)
echo "Running Ansible playbooks as $ANSIBLE_USER..."
sudo -u "$ANSIBLE_USER" ansible-playbook \
  ansible/playbooks/main.yml \
  -i ./ansible/inventory/hosts.ini \
  --extra-vars "\
    ansible_user=$ANSIBLE_USER \
    ansible_become_user=$ANSIBLE_USER \
    ansible_become_pass=$(sudo -v -u "$ANSIBLE_USER")"
