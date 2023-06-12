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

# Install and set to use zsh if not already default
if [[ $(command -v zsh) == "" ]]; then
  echo "Installing zsh..."
  brew install zsh

fi

# Install Oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh my zsh installed"
else
  echo "Installing Oh my zsh..."
  rm -rf ~/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Configure Zsh, Oh my Zsh and Plugins

echo "Settings as default shell..."
chsh -s $(which zsh)
# Install fonts
echo "Installing fonts..."
brew install --cask homebrew/cask-fonts/font-fira-code
brew install --cask homebrew/cask-fonts/font-hack-nerd-font

# Install powerlevel10k
echo "Installing Powerlevel10k..."
rm -rf $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Symlinking .p10k.zsh"
ln -sf "$(pwd)/.p10k.zsh" $HOME/.p10k.zsh
#echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> $HOME/.zshrc

echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Set Oh my zsh theme
echo "Configuring Oh my zsh theme..."
ln -sf "($pwd)/.oh-my-zsh/themes/mitteldorf.zsh-theme" $HOME/.oh-my-zsh/themes/

# Configure Homebrew Brewfile and install programs
if [[ "$OSTYPE" =~ ^darwin ]]; then
  # Symlink Brewfile based on machine type
  echo "Symlinking Brewfile..."
  ln -sf "$(pwd)/Brewfile" $HOME/Brewfile

  # Append additional Homebrew packages depending on machine-use

  cd $HOME

  # Install programs via Homebrew
  echo "Installing programs for macOS via Homebrew..."
  brew bundle install

  cd $(pwd)
fi
