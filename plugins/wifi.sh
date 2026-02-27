#!/bin/bash

get_wifi_device() {
  networksetup -listallhardwareports |
    awk '/Hardware Port: Wi-Fi/{getline; sub(/^Device: /, ""); print; exit}'
}

get_ssid() {
  local wifi_device="$1"
  ipconfig getsummary "$wifi_device" 2>/dev/null |
    awk -F ' : ' '/^[[:space:]]*SSID[[:space:]]*: / {print $2; exit}'
}

get_interface_status() {
  local wifi_device="$1"
  ifconfig "$wifi_device" 2>/dev/null |
    awk -F ': ' '/status: / {print $2; exit}'
}

update() {
  source "$CONFIG_DIR/icons.sh"
  WIFI_DEVICE="$(get_wifi_device)"
  INFO="$(get_ssid "$WIFI_DEVICE")"
  INTERFACE_STATUS="$(get_interface_status "$WIFI_DEVICE")"

  IP_ADDRESS=""
  if [ -n "$WIFI_DEVICE" ]; then
    IP_ADDRESS="$(ipconfig getifaddr "$WIFI_DEVICE" 2>/dev/null)"
  fi

  IS_CONNECTED=0
  if [ "$INTERFACE_STATUS" = "active" ] && [ -n "$IP_ADDRESS" ]; then
    IS_CONNECTED=1
  fi

  if [ -n "$INFO" ] && [ "$IS_CONNECTED" -eq 1 ]; then
    LABEL="$INFO ($IP_ADDRESS)"
  elif [ -n "$INFO" ]; then
    LABEL="$INFO"
  elif [ "$IS_CONNECTED" -eq 1 ] && [ -n "$IP_ADDRESS" ]; then
    LABEL="Connected ($IP_ADDRESS)"
  else
    LABEL="Not Connected"
  fi

  ICON="$([ "$IS_CONNECTED" -eq 1 ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"

  sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
}

click() {
  CURRENT_WIDTH="$(sketchybar --query "$NAME" | jq -r .label.width)"

  WIDTH=0
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
  fi

  sketchybar --animate sin 20 --set "$NAME" label.width="$WIDTH"
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac
