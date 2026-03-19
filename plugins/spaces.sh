#!/bin/bash

sid="${NAME#space.}"
focused_workspace="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
window_count="$(aerospace list-windows --workspace "$sid" --count 2>/dev/null)"

if ! [[ "$window_count" =~ ^[0-9]+$ ]]; then
  window_count=0
fi

target_display=""
for mid in $(aerospace list-monitors --format '%{monitor-id}' 2>/dev/null); do
  if aerospace list-workspaces --monitor "$mid" --empty no 2>/dev/null | grep -Fxq "$sid"; then
    target_display="$mid"
    break
  fi
done

apps="$(aerospace list-windows --workspace "$sid" --json 2>/dev/null | awk -F '"' '/"app-name"/ { print $4 }')"
icon_strip=""

if [ -n "$apps" ]; then
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    glyph="$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    [ -n "$glyph" ] && icon_strip="$icon_strip $glyph"
  done <<< "$apps"
fi

if [ "$sid" != "$focused_workspace" ] && [ "$window_count" -eq 0 ]; then
  if [ -n "$target_display" ]; then
    sketchybar --set "$NAME" display="$target_display" drawing=off label=""
  else
    sketchybar --set "$NAME" drawing=off label=""
  fi
  exit 0
fi

if [ "$sid" = "$focused_workspace" ]; then
  if [ -n "$target_display" ]; then
    sketchybar --set "$NAME" \
               display="$target_display" \
               drawing=on \
               icon.color=0xff1e1e2e \
               background.drawing=on \
               label="$icon_strip" \
               label.padding_left=10 \
               label.padding_right=12
  else
    sketchybar --set "$NAME" \
               drawing=on \
               icon.color=0xff1e1e2e \
               background.drawing=on \
               label="$icon_strip" \
               label.padding_left=10 \
               label.padding_right=12
  fi
else
  if [ -n "$target_display" ]; then
    sketchybar --set "$NAME" \
               display="$target_display" \
               drawing=on \
               icon.color=0xffcba6f7 \
               background.drawing=off \
               label="$icon_strip" \
               label.padding_left=8 \
               label.padding_right=10
  else
    sketchybar --set "$NAME" \
               drawing=on \
               icon.color=0xffcba6f7 \
               background.drawing=off \
               label="$icon_strip" \
               label.padding_left=8 \
               label.padding_right=10
  fi
fi
