#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

cpu=(
  icon="$CPU"
  icon.font="$FONT:Regular:16.0"
  icon.color=$WHITE
  label="0%"
  update_freq=3
  script="$PLUGIN_DIR/cpu.sh"
  padding_right=5
  padding_left=5
)

sketchybar --add item cpu right \
           --set cpu "${cpu[@]}"
