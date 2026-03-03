#!/usr/bin/env bash
SETTINGS="$HOME/.config/Code/User/settings.json"
COLORS="$HOME/.config/matugen/vscode-colors.json"

mkdir -p "$(dirname "$SETTINGS")"

# Create empty settings.json if it doesn't exist
if [ ! -f "$SETTINGS" ]; then
    echo "{}" > "$SETTINGS"
fi

python3 - <<EOF
import json

with open("$SETTINGS") as f:
    settings = json.load(f)

with open("$COLORS") as f:
    colors = json.load(f)

# Merge material-code.colors into settings
settings["material-code.colors"] = colors["material-code.colors"]

with open("$SETTINGS", "w") as f:
    json.dump(settings, f, indent=4)
EOF
