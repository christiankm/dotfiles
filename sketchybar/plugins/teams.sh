#!/bin/sh

# Shows Teams' Dock badge: the number of unread chats and mentions. Only asks
# while Teams is running, as asking would otherwise fail.

. "$(dirname "$0")/badge.sh"

if ! pgrep -xq MSTeams; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

BADGE="$(osascript -e 'tell application "System Events" to tell process "Dock" to get value of attribute "AXStatusLabel" of UI element "Microsoft Teams" of list 1')"

if [ "$BADGE" = "missing value" ] || [ "$BADGE" = "" ]; then
  BADGE="0"
fi

set_badge "$BADGE"
