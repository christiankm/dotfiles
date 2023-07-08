#!/bin/sh

# This script will install all required software, packages and tools on a new machine, to my liking.
# It will configure them as needed, and setup all program configurations and settings.
# This script can be run on any machine, on any OS, and should act accordingly.

set -e # stop on first error

# Ask for the administrator password upfront
sudo -v

DOTFILES=$(pwd)

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

echo "Settings zsh as default shell..."
shell_path="$(command -v zsh)"
if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
  echo "Adding '$shell_path' to /etc/shells"
  sudo sh -c "echo $shell_path >> /etc/shells"
fi
sudo chsh -s "$shell_path" "$USER"

# Install Oh my zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh my zsh installed"
else
  echo "Installing Oh my zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Configure Zsh, Oh my Zsh and Plugins

# Install fonts
echo "Installing fonts..."
brew install --cask homebrew/cask-fonts/font-fira-code
brew install --cask homebrew/cask-fonts/font-hack-nerd-font

# Install powerlevel10k
echo "Installing Powerlevel10k..."
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Symlinking .p10k.zsh"
ln -sf "$(pwd)/.p10k.zsh" $HOME/.p10k.zsh

echo "Installing zsh-syntax-highlighting..."
rm -rf ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-autosuggestions..."
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Set Oh my zsh theme
echo "Configuring Oh my zsh theme..."
mkdir -p $HOME/.oh-my-zsh/themes
ln -sf "($pwd)/mitteldorf.zsh-theme" $HOME/.oh-my-zsh/themes/mitteldorf.zsh-theme

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
  brew update

  cd $DOTFILES
fi

# Symlink dotfiles to users home folder
echo "Symlinking .zshrc"
ln -sf "$(pwd)/.zshrc" $HOME/.zshrc

# Copy .hushlogin
ln -sf "$(pwd)/.hushlogin" $HOME/.hushlogin

# Configure vim
mkdir -p $HOME/.vim
ln -sf "$(pwd)/vimrc" $HOME/.vimrc

# Configure git
ln -sf "$(pwd)/gitconfig" $HOME/.gitconfig
ln -sf "$(pwd)/gitignore" $HOME/.gitignore
git config --global core.excludesfile $HOME/.gitignore

# Configure ssh
mkdir -p $HOME/.ssh
ln -sf "$(pwd)/ssh/config" $HOME/.ssh/config
chmod 600 $HOME/.ssh/config

# Symlink files for Xcode
mkdir -p $HOME/Library/Developer/Xcode/UserData/xcdebugger/
ln -sf "$(pwd)/xcode/Fira Code Dark.xccolortheme" "$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/"
ln -sf "$(pwd)/xcode/Breakpoints_v2" "$HOME/Library/Developer/Xcode/UserData/xcdebugger/"

# Configure macOS Preferences
sh $(pwd)/configure-macos-preferences.sh


# Initialize new settings
source ~/.zshrc

echo "All done. Please reboot computer to make all changes take effect"
