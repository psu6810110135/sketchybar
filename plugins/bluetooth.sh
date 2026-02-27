#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

update() {
  BT_STATUS=$(blueutil --power 2>/dev/null)

  if [ "$BT_STATUS" = "1" ]; then
    # Bluetooth is ON — get connected devices
    CONNECTED_DEVICES=$(blueutil --connected --format json 2>/dev/null | \
      python3 -c "import sys,json; devs=json.load(sys.stdin); print(', '.join(d.get('name','Unknown') for d in devs))" 2>/dev/null)

    if [ -n "$CONNECTED_DEVICES" ]; then
      ICON="$BLUETOOTH_CONNECTED"
      LABEL="$CONNECTED_DEVICES"
      ICON_COLOR="$BLUE"
    else
      ICON="$BLUETOOTH_ON"
      LABEL="On"
      ICON_COLOR="$WHITE"
    fi
  else
    ICON="$BLUETOOTH_DISCONNECTED"
    LABEL="Off"
    ICON_COLOR="$GREY"
  fi

  sketchybar --set "$NAME" icon="$ICON" label="$LABEL" icon.color="$ICON_COLOR"
}

click() {
  if [ "$BUTTON" = "right" ]; then
    # Right-click: toggle Bluetooth on/off
    BT_STATUS=$(blueutil --power 2>/dev/null)
    if [ "$BT_STATUS" = "1" ]; then
      blueutil --power 0
    else
      blueutil --power 1
    fi
    sleep 1
    update
  else
    # Left-click: expand/collapse label
    CURRENT_WIDTH="$(sketchybar --query "$NAME" | jq -r .label.width)"

    WIDTH=0
    if [ "$CURRENT_WIDTH" -eq "0" ]; then
      WIDTH=dynamic
    fi

    sketchybar --animate sin 20 --set "$NAME" label.width="$WIDTH"
  fi
}

case "$SENDER" in
  "mouse.clicked") click ;;
  *) update ;;
esac
