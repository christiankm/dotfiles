#!/bin/sh

# Uninstall software (leave settings)
#brew uninstall

# Remove files and folders
rm -rf $HOME/.oh-my-zsh
rm $HOME/Brewfile
rm $HOME/.zshrc
rm $HOME/.p10k.zsh
rm $HOME/.hushlogin

# Unlink filesunlink ~/Brewfile
unlink ~/.zshrc
# Reset to default preferences
defaults delete com.apple.TextEdit

# Done
echo "Removed everything. It's recommended to reboot the machine now."
