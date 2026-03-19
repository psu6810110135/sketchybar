#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
ACCENT=0xff55efe2
ACCENT_DIM=0xaa55efe2
ACTIVE_TEXT=0xff042436

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    associated_space=$sid
    script="$PLUGIN_DIR/spaces.sh"
    icon="${SPACE_ICONS[i]}"
    icon.font="$FONT:Semibold:15.0"
    icon.padding_left=10
    icon.padding_right=4
    icon.color=$ACCENT
    padding_left=2
    padding_right=2
    label="-"
    label.font="$FONT:Semibold:16.0"
    label.padding_left=0
    label.padding_right=12
    label.color=$ACCENT_DIM
    label.highlight_color=$ACTIVE_TEXT
    background.color=$ACCENT
    background.corner_radius=7
    background.height=28
    background.drawing=off
    icon.highlight_color=$ACTIVE_TEXT
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid space_change
done

