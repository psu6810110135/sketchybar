#!/bin/bash

format_count() {
  local value="$1"
  if [[ "$value" =~ ^[0-9]+$ ]]; then
    echo "$value"
  else
    echo "0"
  fi
}

update() {
  local left_count right_count
  left_count="$(format_count "${LEFT_COUNT:-0}")"
  right_count="$(format_count "${RIGHT_COUNT:-0}")"

  sketchybar --set "$NAME" label="$left_count ← → $right_count"
}

case "$SENDER" in
  "paperwm_state_change") update
  ;;
  "forced") exit 0
  ;;
  *) update
  ;;
esac
