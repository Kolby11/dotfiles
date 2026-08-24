#!/usr/bin/env bash
# Merge the matugen-generated palette.json into oh-my-posh's theme.json.
# oh-my-posh re-reads its --config file on every prompt render, so the new
# colors appear on the next prompt automatically — no reload signal needed.
#
# NOTE: do NOT `pkill -USR1 bash` here. matugen runs this as a child of
# switchwall.sh (itself a bash process with no USR1 trap), so a broad
# pkill would terminate the theming pipeline mid-run.
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