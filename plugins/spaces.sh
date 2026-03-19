#!/bin/bash

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" \
             icon.color=0xff042436 \
             label.color=0x00000000 \
             background.drawing=on
else
  sketchybar --set "$NAME" \
             icon.color=0xff55efe2 \
             label.color=0xaa55efe2 \
             background.drawing=off
fi