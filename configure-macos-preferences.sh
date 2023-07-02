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

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# System

sudo pmset -a standbydelay 3600                                                     # Set standby delay to 1 hour

defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true    # Switch to Dark Mode automatically
defaults write -globalDomain AppleScrollerPagingBehavior -bool true                 # Click to jump in scroll barrs
defaults write -globalDomain NSTableViewDefaultSizeMode -int 2                      # Set sidebar icon sizes to Medium
defaults -currentHost write com.apple.screensaver idleTime -int 120                 # Start screensaver after 2 minutes

# Menu bar

defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true             # Enable transparency

# Finder

defaults write com.apple.finder AppleShowAllFiles -string NO                       # Don't show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool false                   # Hide file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true          # Show warning before changing an extension
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false   # Don't show warning before removing from iCloud Drive
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"                # View as list by default
defaults write com.apple.finder ShowPathbar -bool true                             # Show Path bar in bottom

# Dock

defaults write com.apple.dock tilesize -int 46                     # Set icon size
defaults write com.apple.dock magnification -bool false            # Disable magnification
defaults write com.apple.dock largesize -int 54                    # Set size when hovering
defaults write com.apple.dock mineffect -string "scale"            # Set minimization animation
defaults write com.apple.dock minimize-to-application -bool true   # Minimize to application symbol
defaults write com.apple.dock autohide -bool true                  # Auto-hide Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5    # Show and hide very quickly
defaults write com.apple.dock autohide-delay -float 0.0            # Hide quickly
defaults write com.apple.dock show-process-indicators -bool true   # Show indicator for open apps

# Trackpad


# Enable Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true


# Tower
defaults write com.fournove.tower3 SUAutomaticallyUpdate -bool YES
defaults write com.fournova.tower3 GTUserDefaultsDiffWarningThreshold -int 100000
# Kill affected apps
echo "Killing affected apps..."
for app in \
  "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Tower" \
	"Xcode" \
  ; do
	killall "${app}" > /dev/null 2>&1
done

echo "Done. Reboot to make all changes take effect"
