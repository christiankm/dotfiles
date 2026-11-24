#!/bin/sh

# set_badge shows a label containing a count and highlights
# the count in red when there are unread notifications

set_badge() {
    if [ "$1" = "0" ] || [ "$1" = "" ]; then
        sketchybar --set "$NAME" drawing=on label="$1" label.color=0xff222222
    else
        sketchybar --set "$NAME" drawing=on label="$1" label.color=0xffff3b30
    fi
}
