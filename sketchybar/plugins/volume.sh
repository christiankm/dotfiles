#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

# Routine updates (to catch a new output device) have no $INFO, so they ask
# for the volume instead.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)')"
fi

# Whether the current output device is headphones or speakers. Bluetooth and
# USB devices, and anything in the headphone jack, count as headphones.
OUTPUT="$(system_profiler SPAudioDataType | awk '
  function finish() { if (is_default) print (is_headphones ? "headphones" : "speakers") }
  /^        [^ ].*:$/ { finish(); is_default = 0; is_headphones = 0 }
  /Default Output Device: Yes/ { is_default = 1 }
  /Transport: (Bluetooth|USB)/ || /Output Source: .*Headphones/ { is_headphones = 1 }
  END { finish() }
')"

if [ "$OUTPUT" = "headphones" ]; then
  case "$VOLUME" in
    0) ICON="󰟎" ;;
    *) ICON="󰋋" ;;
  esac
else
  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾" ;;
    [3-5][0-9]) ICON="󰖀" ;;
    [1-9]|[1-2][0-9]) ICON="󰕿" ;;
    *) ICON="󰖁" ;;
  esac
fi

# Some devices (e.g. many USB headsets) have no software volume
if [ "$VOLUME" = "missing value" ]; then
  sketchybar --set "$NAME" icon="$ICON" label.drawing=off
else
  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" label.drawing=on
fi
