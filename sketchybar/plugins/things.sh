#!/bin/sh

# Shows the number of open to-dos in Things' Today list. Only asks while Things
# is running, as asking would otherwise launch it.

. "$(dirname "$0")/badge.sh"

if ! pgrep -xq Things3; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

COUNT="$(osascript -e 'tell application "Things3" to count (to dos of list "Today" whose status is open)')"

set_badge "$COUNT"
