#!/bin/sh

# Shows the name of the current Wi-Fi network. macOS redacts the SSID unless
# verbose mode is on, which needs running once: sudo ipconfig setverbose 1
#
# When there's no SSID (Ethernet, or the SSID is redacted), it shows the
# network's DHCP domain name instead, e.g. "corp.example.com", if it has one.

# The interface that internet traffic currently goes through, e.g. en0
INTERFACE="$(route -n get default 2>/dev/null | awk '/interface:/ { print $2 }')"

# Its hardware port name, e.g. "Wi-Fi" or "USB 10/100/1G/2.5G LAN"
PORT="$(networksetup -listallhardwareports | awk -v device="Device: $INTERFACE" '
  /^Hardware Port: / { sub(/^Hardware Port: /, ""); port = $0 }
  $0 == device { print port }
')"

# Its local IPv4 address, e.g. 192.168.1.20
IP="$(ipconfig getifaddr "$INTERFACE" 2>/dev/null)"

if [ "$INTERFACE" = "" ]; then
    sketchybar --set "$NAME" icon=􀙈 label="Offline"
elif [ "${IP#172.20.10.}" != "$IP" ]; then
    # An iPhone's Personal Hotspot always hands out 172.20.10.x addresses,
    # whether it's shared over Wi-Fi, USB or Bluetooth
    sketchybar --set "$NAME" icon=󰄜 icon.font="Hack Nerd Font:Regular:15.0" label="$IP"
elif [ "$PORT" = "Wi-Fi" ]; then
    SSID="$(ipconfig getsummary "$INTERFACE" | awk -F ' SSID : ' '/ SSID : / { print $2 }')"
    if [ "$SSID" = "<redacted>" ]; then
        SSID=""
    fi
    NETWORK="${SSID:-$(ipconfig getoption "$INTERFACE" domain_name)}"
    sketchybar --set "$NAME" icon=􀙇 icon.font="SF Pro:Medium:13.0" \
        label="${NETWORK:+$NETWORK }$IP"
else
    DOMAIN="$(ipconfig getoption "$INTERFACE" domain_name)"
    sketchybar --set "$NAME" icon=󰈀 icon.font="Hack Nerd Font:Regular:15.0" \
        label="${DOMAIN:+$DOMAIN }$IP"
fi
