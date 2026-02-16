#!/usr/bin/env bash
THEME="$HOME/.config/omp/theme.json"
PALETTE="$HOME/.config/omp/palette.json"

mkdir -p "$(dirname "$THEME")"
mkdir -p "$(dirname "$PALETTE")"

python3 - <<EOF
import json

with open("$THEME") as f:
    theme = json.load(f)

with open("$PALETTE") as f:
    palette = json.load(f)

theme["palette"] = palette

with open("$THEME", "w") as f:
    json.dump(theme, f, indent=4)
EOF