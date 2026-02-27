#!/bin/bash

get_current_input_name() {
  local selected_sources
  selected_sources="$(defaults read ~/Library/Preferences/com.apple.HIToolbox AppleSelectedInputSources 2>/dev/null)"

  echo "$selected_sources" | awk -F'= ' '/"KeyboardLayout Name" =/{gsub(/;$/, "", $2); gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); print $2; exit}'
}

abbrev_input_name() {
  case "$1" in
    "U.S."|"ABC"|"US") echo "EN" ;;
    "Thai") echo "TH" ;;
    "Japanese") echo "JP" ;;
    "Korean") echo "KO" ;;
    *) echo "$1" ;;
  esac
}

update() {
  local input_name
  input_name="$(get_current_input_name)"

  if [ -z "$input_name" ]; then
    input_name="EN"
  fi

  sketchybar --set "$NAME" label="$(abbrev_input_name "$input_name")"
}

update
