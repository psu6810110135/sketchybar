#!/bin/bash

sid="${NAME#space.}"
visible_workspaces="$(aerospace list-workspaces --monitor all --visible 2>/dev/null)"
focused_workspace="$(aerospace list-workspaces --focused 2>/dev/null)"

if ! echo "$visible_workspaces" | grep -Fxq "$sid"; then
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
             label.background.image="$label_image"
else
  sketchybar --set "$NAME" \
             drawing=on \
             icon.color=0xff94e2d5 \
             background.drawing=off \
             label.background.image="$label_image"
fi