#!/bin/sh

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

# Uninstall software (leave settings)
#brew uninstall

# Remove files and folders
rm -rf $HOME/.oh-my-zsh
rm $HOME/Brewfile
rm $HOME/.zshrc
rm $HOME/.p10k.zsh
rm $HOME/.gitconfig
rm $HOME/.gitignore
rm $HOME/.hushlogin
rm $HOME/.vimrc
rm $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes
rm $HOME/Library/Developer/Xcode/UserData/xcdebugger

# Reset to default preferences
defaults delete com.apple.TextEdit

# Done
success "Removed everything. It's recommended to reboot the machine now."
