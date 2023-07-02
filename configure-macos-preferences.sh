#!/bin/sh

# This script will configure and set up macOS preferences.
# Credit to:
# - https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
#
# -----------------------------------------------------------------------------
# Usage:
#
# Print all domains present on system. Useful for finding new preferences
#  to explore.
# Making the output of domains a little bit cleaner
# If you (like me) are not a big fan of the comma separated output of 
# defaults domains, you can pipe it through a translate command to make the
# output much easier to read.
# defaults domains | tr ',' '\n'
# defaults domains | tr ',' '\n' | grep -i textedit
# defaults read com.apple.Notes
# defaults read-type com.apple.Notes NotesContinuousSpellCheckingEnabled
# defaults write com.apple.Notes NotesContinuousSpellCheckingEnabled -bool true
#
# In order to find out the option name, we do have to go in the TextEdit UI and 
# edit the preference manually. Use ⌘+, then in New Document check the box named 
# Check grammar with spelling. Close the preference pane.
# Now, if you run again the defaults command above, your new output 
# should look like as below and include the CheckGrammarWithSpelling key.
# $ defaults read com.apple.TextEdit
# {
#     ...  
#     CheckGrammarWithSpelling = 1;
#     ...
# }
# -----------------------------------------------------------------------------


# System

# Switch to Dark Mode automatically
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# Finder

# Finder > Hide hidden files
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


# Tower
defaults write com.fournove.tower3 SUAutomaticallyUpdate -bool YES
defaults write com.fournova.tower3 GTUserDefaultsDiffWarningThreshold -int 100000
# Kill affected apps
echo "Restarting affected apps..."
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

echo "Reboot to make all changes take effect"
