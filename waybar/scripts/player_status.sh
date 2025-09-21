#!/usr/bin/env zsh

set -euo pipefail

print_status() {
  local state artist track icon class tooltip

  state=$(playerctl status 2>/dev/null || echo "Stopped")

  case "$state" in
    Playing) class="playing"; icon="" ;; 
    Paused)  class="paused";  icon="" ;;
    Stopped) class="stopped"; icon="" ;;
    *)       class="disconnected"; icon="" ;;
  esac

  artist=$(playerctl metadata artist 2>/dev/null || echo "")
  track=$(playerctl metadata title 2>/dev/null || echo "")

  if [[ -n "$artist" || -n "$track" ]]; then
    tooltip="${artist:+$artist}$( [[ -n $artist && -n $track ]] && echo " – " )${track:+$track}"
  else
    tooltip="No track info"
  fi

  safe_tooltip=${tooltip//\"/\\\"}

  printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$icon" "$class" "$safe_tooltip"
}

if [[ "${WAYBAR_RUN_ONCE:-0}" == "1" ]]; then
  print_status
  exit 0
fi

print_status

playerctl --follow status &  
playerctl --follow metadata &  

while read -r _; do
  print_status
done < <(playerctl --follow status 2>/dev/null & playerctl --follow metadata 2>/dev/null)
