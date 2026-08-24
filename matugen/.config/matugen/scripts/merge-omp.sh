#!/usr/bin/env bash
# Merge the matugen-generated palette.json into oh-my-posh's theme.json.
# Interactive Fish checks the theme timestamp at command boundaries and
# reloads the prompt safely before the next prompt is rendered.
THEME="$HOME/.config/omp/theme.json"
PALETTE="$HOME/.config/omp/palette.json"

[ -f "$THEME" ] || exit 0
[ -f "$PALETTE" ] || exit 0

python3 - "$THEME" "$PALETTE" <<'EOF'
import json, sys

theme_path, palette_path = sys.argv[1], sys.argv[2]
with open(theme_path) as f:
    theme = json.load(f)
with open(palette_path) as f:
    theme["palette"] = json.load(f)
with open(theme_path, "w") as f:
    json.dump(theme, f, indent=4)
EOF
