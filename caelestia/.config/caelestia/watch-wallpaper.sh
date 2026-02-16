#!/usr/bin/env bash

STATE_DIR="$HOME/.local/state/caelestia/wallpaper"
CURRENT="$STATE_DIR/current"

inotifywait -m -e create -e moved_to "$STATE_DIR" --format '%f' |
while read -r file; do
    if [[ "$file" == "current" ]]; then
        WALL_PATH=$(readlink -f "$CURRENT")
        if [[ -f "$WALL_PATH" ]]; then
            matugen image "$WALL_PATH"
        fi
    fi
done