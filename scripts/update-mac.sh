#!/bin/sh

# Install system updates and installables from the Mac App Store
sudo softwareupdate --all --install --verbose

# Upgrade all Homebrew packages
brew update
brew upgrade
brew upgrade --cask --greedy
mas upgrade

# Clean up Homebrew
brew cleanup
brew doctor -v
