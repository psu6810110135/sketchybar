#!/bin/bash

keyboard=(
  icon=􀫨
  icon.font="$FONT:Regular:14.0"
  label.width=26
  label.align=center
  update_freq=2
  script="$PLUGIN_DIR/keyboard.sh"
)

sketchybar --add item keyboard right       \
           --set keyboard "${keyboard[@]}" \
           --subscribe keyboard system_woke
