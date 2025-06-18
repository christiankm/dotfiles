#!/bin/sh

# Update all Homebrew packages
brew update
brew upgrade --greedy
brew cleanup
brew doctor -v

# Install system updates and installables from the Mac App Store
sudo softwareupdate -i -a --verbose
