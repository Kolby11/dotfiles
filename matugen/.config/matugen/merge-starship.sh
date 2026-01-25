#!/usr/bin/env bash

# Merge the generated colors into the main starship config
COLORS_FILE="$HOME/.config/starship-colors.toml"
MAIN_CONFIG="$HOME/.config/starship.toml"
TEMP_CONFIG="$HOME/.config/starship-temp.toml"

if [[ -f "$COLORS_FILE" ]]; then
    # Read the main config and replace the [palettes.matugen] section
    awk '
    /^\[palettes\.matugen\]/ { 
        print $0
        system("cat '"$COLORS_FILE"'")
        skip=1
        next
    }
    /^\[/ && skip { skip=0 }
    !skip { print }
    ' "$MAIN_CONFIG" > "$TEMP_CONFIG"
    
    mv "$TEMP_CONFIG" "$MAIN_CONFIG"
fi