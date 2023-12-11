#!/bin/sh

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

# Unlink symlinks
unlink $HOME/Brewfile
unlink $HOME/.zshrc
unlink $HOME/.p10k.zsh
unlink $HOME/.gitconfig
unlink $HOME/.gitignore
unlink $HOME/.hushlogin
unlink $HOME/.ssh/config
unlink $HOME/.vimrc

# Remove files and folders
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.zcomp*
rm -rf $HOME/.zprofile

rm $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes
rm $HOME/Library/Developer/Xcode/UserData/xcdebugger

# Reset to default preferences
defaults delete com.apple.TextEdit
defaults delete com.fournova.tower3

# Done
success "Removed everything. It's recommended to reboot the machine now."
