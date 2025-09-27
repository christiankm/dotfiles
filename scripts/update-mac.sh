#!/bin/sh

# Install system updates and installables from the Mac App Store
sudo softwareupdate --all --install --verbose

# Install Mac App Store updates
mas upgrade

# Upgrade Homebrew packages
brew update
brew upgrade
brew upgrade --cask

# Clean up Homebrew
brew cleanup
brew doctor -v
