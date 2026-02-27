#!/bin/bash

source "$CONFIG_DIR/icons.sh"

bluetooth=(
  padding_right=7
  label.width=0
  icon="$BLUETOOTH_DISCONNECTED"
  icon.width=dynamic
  icon.font="$FONT:Regular:16.0"
  script="$PLUGIN_DIR/bluetooth.sh"
  click_script="$PLUGIN_DIR/bluetooth.sh"
  update_freq=30
)

sketchybar --add item bluetooth right \
           --set bluetooth "${bluetooth[@]}" \
           --subscribe bluetooth mouse.clicked
