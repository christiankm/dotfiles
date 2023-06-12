#!/bin/sh

# Uninstall software (leave settings)
#brew uninstall

# Remove files and folders
rm -rf ~/.oh-my-zsh
rm ~/.zshrc*

# Unlink filesunlink ~/Brewfile
unlink ~/.zshrc

# Done
echo "Removed everything. It's recommended to reboot the machine now."
