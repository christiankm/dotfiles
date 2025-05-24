#!/bin/sh

# Install system updates and installables from the Mac App Store
sudo softwareupdate -i -a --verbose

# Upgrade all Homebrew packages
brew update
brew upgrade
brew cleanup
brew doctor -v
