#!/bin/bash

# Compact app-to-glyph mapping inspired by aerospace-sketchybar.
# Uses sketchybar-app-font glyph names.
icon_map() {
  case "$1" in
    "Code"|"Code - Insiders"|"Cursor")
      echo ":code:"
      ;;
    "Brave Browser")
      echo ":brave_browser:"
      ;;
    "Google Chrome"|"Chromium")
      echo ":google_chrome:"
      ;;
    "Safari")
      echo ":safari:"
      ;;
    "iTerm2"|"iTerm"|"Terminal"|"Ghostty"|"kitty"|"WezTerm")
      echo ":terminal:"
      ;;
    "Finder")
      echo ":finder:"
      ;;
    "Spotify")
      echo ":spotify:"
      ;;
    "Slack")
      echo ":slack:"
      ;;
    "Discord")
      echo ":discord:"
      ;;
    "Mail"|"Canary Mail"|"HEY"|"Spark")
      echo ":mail:"
      ;;
    "Messages")
      echo ":messages:"
      ;;
    "Calendar"|"Notion Calendar")
      echo ":calendar:"
      ;;
    "Music")
      echo ":music:"
      ;;
    "Obsidian")
      echo ":obsidian:"
      ;;
    "Notion")
      echo ":notion:"
      ;;
    "Docker"|"Docker Desktop"|"OrbStack")
      echo ":docker:"
      ;;
    "System Settings"|"System Preferences")
      echo ":gear:"
      ;;
    "Preview")
      echo ":pdf:"
      ;;
    "Notes")
      echo ":notes:"
      ;;
    *)
      echo ":default:"
      ;;
  esac
}

icon_map "$1"
