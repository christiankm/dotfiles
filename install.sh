#!/bin/sh

# This script will install all required software, packages and tools on a new machine, to my liking.
# It will configure them as needed, and setup all program configurations and settings.
# This script can be run on any machine, on any OS, and should act accordingly.

set -e # stop on first error

# Ask for the administrator password upfront
sudo -v

success() {
  printf "\r\033[2K  [\033[00;32mOK\033[0m] %s\n" "$1"
}

DOTFILES=$(pwd)

# Detect OS
printf "Detected OS: "
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
  fi
  
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

  success "Homebrew installed to $(which brew)"
fi

# Symlink dotfiles
ln -sf "$(pwd)/.hushlogin" $HOME/.hushlogin
ln -sf "$(pwd)/.zshrc" $HOME/.zshrc

# Reload new settings
source $HOME/.zshrc

# Cleanup
rm -rf $HOME/.zcompdump*
rm -rf $HOME/.zshrc.pre-oh-my-*

success "All done. Please reboot computer to make all changes take effect"
