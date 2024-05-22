#!/bin/sh

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

# Ask for the administrator password upfront
sudo -v -u $(whoami)

# Uninstall fonts
brew uninstall font-fira-code
brew uninstall font-hack-nerd-font
brew untap homebrew/cask-fonts

# Unlink symlinks
unlink $HOME/Brewfile
unlink $HOME/.gitconfig
unlink $HOME/.gitignore
unlink $HOME/.hushlogin
unlink $HOME/.p10k.zsh
unlink $HOME/.ssh/config
unlink $HOME/.vimrc
unlink $HOME/.zshrc

# Remove files and folders
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.todo
rm -rf $HOME/.zcomp*
rm -rf $HOME/.zprofile
rm -rf $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes
rm -rf $HOME/Library/Developer/Xcode/UserData/xcdebugger

# Reset to default preferences
defaults delete com.apple.TextEdit
defaults delete com.fournova.tower3

# Done
success "Removed everything. It's recommended to reboot the machine now."
