#!/usr/bin/env zsh 

export PATH="$HOME/go/bin:$PATH"

cliphist list | rofi -dmenu | cliphist decode | wl-copy && sleep 0.1 && wtype -M ctrl -M shift -k v -m ctrl -m shift