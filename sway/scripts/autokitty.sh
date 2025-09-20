#!/bin/sh

# This script listens for workspace focus events in Sway.
# If the newly focused workspace is empty (has no windows), it opens a kitty terminal.

swaymsg -t subscribe -m '["workspace"]' | jq --line-buffered '.change' | while read -r change; do
    # We only care about "focus" events
    if [ "$change" = '"focus"' ]; then
        # Get the number of windows and floating windows on the currently focused workspace
        workspace_content=$(swaymsg -t get_tree | jq '.. | select(.type? == "workspace" and .focused?) | .nodes + .floating_nodes | length')

        # If the number of windows is 0, the workspace is empty
        if [ "$workspace_content" -eq 0 ]; then
            swaymsg exec kitty
        fi
    fi
done
