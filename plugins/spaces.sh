#!/bin/bash

sid="${NAME#space.}"
focused_workspace="$(aerospace list-workspaces --focused 2>/dev/null)"
window_count="$(aerospace list-windows --workspace "$sid" --count 2>/dev/null)"

if ! [[ "$window_count" =~ ^[0-9]+$ ]]; then
  window_count=0
fi

if [ "$sid" != "$focused_workspace" ] && [ "$window_count" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

app_name="$(aerospace list-windows --workspace "$sid" --json 2>/dev/null | awk -F '"' '/"app-name"/ { print $4; exit }')"

if [ -n "$app_name" ]; then
  label_image="app.$app_name"
else
  label_image=""
fi

if [ "$sid" = "$focused_workspace" ]; then
  sketchybar --set "$NAME" \
             drawing=on \
             icon.color=0xff1e1e2e \
             background.drawing=on \
             label.width=24 \
             label.padding_left=10 \
             label.padding_right=12 \
             label.background.image="$label_image"
else
  sketchybar --set "$NAME" \
             drawing=on \
             icon.color=0xffcba6f7 \
             background.drawing=off \
             label.width=20 \
             label.padding_left=8 \
             label.padding_right=10 \
             label.background.image="$label_image"
fi
