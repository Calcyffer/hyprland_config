#!/bin/bash

# Find the PID of Firefox
firefox_pid=$(pidof firefox | awk '{print $1}')

# Query Hyprland clients
workspace=$(hyprctl clients -j | jq -r --arg pid "$firefox_pid" '.[] | select(.pid == ($pid | tonumber)) | .workspace.id' | head -n 1)

if [ -n "$workspace" ]; then
    hyprctl dispatch workspace "$workspace"
else
    # If Firefox isn't open, optionally launch it
    firefox https://github.com &
fi
