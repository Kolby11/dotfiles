#!/usr/bin/env bash
# Merge the generated colors into the main starship config
COLORS_FILE="$HOME/.config/starship/palette.toml"
MAIN_CONFIG="$HOME/.config/starship/starship.toml"  # Match your STARSHIP_CONFIG
TEMP_CONFIG="$HOME/.config/starship/starship-temp.toml"

if [[ -f "$COLORS_FILE" ]]; then
    if grep -q '^\[palettes\.matugen\]' "$MAIN_CONFIG"; then
        # Section exists - replace it
        awk '
        /^\[palettes\.matugen\]/ {
            print "[palettes.matugen]"
            while ((getline line < "'"$COLORS_FILE"'") > 0) {
                if (line !~ /^\[palettes\.matugen\]/) print line
            }
            close("'"$COLORS_FILE"'")
            in_palette=1
            next
        }
        /^\[/ && in_palette { in_palette=0 }
        !in_palette { print }
        ' "$MAIN_CONFIG" > "$TEMP_CONFIG"

        # Overwrite contents WITHOUT breaking symlink
        cat "$TEMP_CONFIG" > "$MAIN_CONFIG"
        rm "$TEMP_CONFIG"
    else
        # Section doesn't exist - append it
        echo "" >> "$MAIN_CONFIG"
        cat "$COLORS_FILE" >> "$MAIN_CONFIG"
    fi
    echo "Merged palette into starship config"
fi
