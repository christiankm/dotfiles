#!/bin/sh

# Keeps the bar short on narrow displays, such as the MacBook's own screen.
# Runs when the active display changes, or when a display is connected or
# disconnected.

PATH="/opt/homebrew/bin:$PATH"

NARROW_WIDTH=2000

DISPLAYS="$(sketchybar --query displays)"
WIDE="$(echo "$DISPLAYS" | jq -r --argjson narrow "$NARROW_WIDTH" \
    '[.[] | select(.frame.w >= $narrow) | ."arrangement-id"] | join(",")')"
NARROW="$(echo "$DISPLAYS" | jq -r --argjson narrow "$NARROW_WIDTH" \
    '[.[] | select(.frame.w < $narrow) | ."arrangement-id"] | join(",")')"

# Shows the matching items on the given displays
show_on() {
    if [ "$2" = "" ]; then
        sketchybar --set "$1" drawing=off
    else
        sketchybar --set "$1" drawing=on display="$2"
    fi
}

show_on '/space\.[0-9]/' "$WIDE"
show_on '/space\.short\./' "$NARROW"
show_on battery "$WIDE"
show_on volume "$WIDE"
show_on network "$WIDE"
show_on claude "$WIDE"
show_on copilot "$WIDE"
