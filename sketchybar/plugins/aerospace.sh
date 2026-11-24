#!/bin/sh

# Called once per space item with the workspace number as $1. The
# aerospace_workspace_change event (triggered from aerospace.toml's
# exec-on-workspace-change) supplies the currently focused workspace in
# $FOCUSED_WORKSPACE, so we can highlight the matching space item.

#
# On startup or reload there's no event, so we ask AeroSpace instead.

PATH="/opt/homebrew/bin:$PATH"

if [ "$FOCUSED_WORKSPACE" = "" ]; then
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi
