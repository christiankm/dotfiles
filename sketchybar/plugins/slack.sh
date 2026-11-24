#!/bin/sh

# Shows Slack's Dock badge: the number of mentions and DMs, or "•" for unread
# channels. Only asks while Slack is running, as asking would otherwise fail.

. "$(dirname "$0")/badge.sh"

if ! pgrep -xq Slack; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

BADGE="$(osascript -e 'tell application "System Events" to tell process "Dock" to get value of attribute "AXStatusLabel" of UI element "Slack" of list 1')"

if [ "$BADGE" = "missing value" ] || [ "$BADGE" = "" ]; then
  BADGE="0"
fi

set_badge "$BADGE"
