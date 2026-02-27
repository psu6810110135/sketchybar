#!/bin/bash

paperwm=(
  icon=􀂓
  icon.font="$FONT:Regular:13.0"
  label="0 ← → 0"
  label.font="$FONT:Semibold:12.0"
  script="$PLUGIN_DIR/paperwm.sh"
  updates=on
  associated_display=active
)

sketchybar --add event paperwm_state_change            \
           --add item paperwm left                     \
           --set paperwm "${paperwm[@]}"              \
           --subscribe paperwm paperwm_state_change    \
                               system_woke
