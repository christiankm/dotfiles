#!/bin/sh

# Remove files and folders
rm -rf ~/.oh-my-zsh
rm ~/.zshrc*

# Unlink files
unlink ~/Brewfile
unlink ~/.zshrc

# Done
echo "Removed everything. It's recommended to reboot the machine now."