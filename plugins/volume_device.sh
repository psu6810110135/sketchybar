#!/bin/bash

command -v SwitchAudioSource >/dev/null || exit 0

INDEX="${NAME##*.}"
if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
  exit 0
fi

DEVICE="$(SwitchAudioSource -a -t output | sed -n "$((INDEX + 1))p")"
if [ -z "$DEVICE" ]; then
  exit 0
fi

SwitchAudioSource -s "$DEVICE" >/dev/null 2>&1 || exit 0
source "$CONFIG_DIR/colors.sh"

sketchybar --set /volume.device\.*/ label.color="$GREY" \
           --set "$NAME" label.color="$WHITE" \
           --set volume_icon popup.drawing=off
