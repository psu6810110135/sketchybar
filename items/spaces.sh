#!/bin/bash

ACCENT=$MAGENTA

WORKSPACES=()
while IFS= read -r workspace; do
  [ -n "$workspace" ] && WORKSPACES+=("$workspace")
done < <(aerospace list-workspaces --all 2>/dev/null)

if [ ${#WORKSPACES[@]} -eq 0 ]; then
  WORKSPACES=("1")
fi

sketchybar --add event aerospace_workspace_change

for sid in "${WORKSPACES[@]}"
do
  space=(
    script="$PLUGIN_DIR/spaces.sh"
    click_script="aerospace workspace $sid"
    update_freq=2
    updates=on
    icon="$sid"
    icon.font="$FONT:Semibold:15.0"
    icon.padding_left=10
    icon.padding_right=6
    icon.color=$ACCENT
    label=""
    label.width=20
    label.padding_left=8
    label.padding_right=10
    label.background.drawing=on
    label.background.image.scale=0.66
    background.color=$ACCENT
    background.corner_radius=7
    background.height=28
    background.drawing=off
    drawing=on
    padding_left=3
    padding_right=3
  )

  sketchybar --add item space.$sid left         \
             --set space.$sid "${space[@]}"    \
             --subscribe space.$sid aerospace_workspace_change \
                                   front_app_switched         \
                                   display_change             \
                                   system_woke
done

sketchybar --trigger aerospace_workspace_change

