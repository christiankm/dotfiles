#!/bin/sh

# This script will install all required software, packages and tools on a new machine, to my liking.
# It will configure them as needed, and setup all program configurations and settings.
# This script can be run on any machine, on any OS, and should act accordingly.

set -e # stop on first error

# Detect OS
echo "Detected OS:"
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "MACOS" ;; 
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

# Install package manager

# Install Homebrew, if macOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
  if [[ $(command -v brew) == "" ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Add Homebrew to PATH
  if [[ $(uname -m) == 'arm64' ]]; then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$(whoami)/.zprofile # for Apple Sillicon Mac
    eval "$(/opt/homebrew/bin/brew shellenv)" # for Apple Sillicon Mac
  else
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/$(whoami)/.zprofile # for Intel Mac
    eval "$(/usr/local/bin/brew shellenv)" # for Intel Mac
  fi

  echo "Homebrew installed to $(which brew)"

  # Opt-out of Homebrew analytics
  echo "Disabling Homebrew analytics..."
  export HOMEBREW_NO_ANALYTICS=1
  brew analytics off
fi

