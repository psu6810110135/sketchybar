#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CORE_COUNT=$(sysctl -n hw.logicalcpu)
TOTAL_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.2f", s}')
CPU_USAGE=$(awk "BEGIN {printf \"%.0f\", $TOTAL_USAGE / $CORE_COUNT}")

if [ "$CPU_USAGE" -ge 70 ]; then
  COLOR="$RED"
elif [ "$CPU_USAGE" -ge 30 ]; then
  COLOR="$ORANGE"
elif [ "$CPU_USAGE" -ge 10 ]; then
  COLOR="$YELLOW"
else
  COLOR="$LABEL_COLOR"
fi

sketchybar --set "$NAME" label="${CPU_USAGE}%" label.color="$COLOR"
