#!/bin/sh

# This script will configure and set up macOS preferences.
# Credit to:
# - https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
#

# General

echo "Switch to Dark Mode automatically..."
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# Finder

# Hide hidden files
echo "Hiding hidden files..."
defaults write com.apple.finder AppleShowAllFiles -string NO

# Dock

echo "Configuring Dock..."
defaults write com.apple.dock tilesize -int 46
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 54
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-process-indicators -bool true

# Trackpad

echo "Configuring Trackpad..."

# Enable Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Kill affected apps
echo "Restarting affected apps..."
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done
