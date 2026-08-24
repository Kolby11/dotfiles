#!/usr/bin/env bash
set -euo pipefail

settings="$HOME/.config/Code/User/settings.json"
colors="$HOME/.config/matugen/vscode-colors.json"

[[ -f "$colors" ]] || exit 0

mkdir -p "$(dirname "$settings")"
if [[ ! -f "$settings" ]]; then
    printf '{\n}\n' > "$settings"
fi

# The generated file is a small, valid JSON object. Keep only its inner
# property so the user's JSONC comments, trailing commas, and formatting stay
# untouched when the palette changes.
fragment="$(sed '1d;$d' "$colors")"
newline=$'\n'
if grep -q $'\r$' "$settings"; then
    newline=$'\r\n'
    fragment="${fragment//$'\n'/$'\r\n'}"
fi
temporary_settings="$(mktemp "${settings}.XXXXXX")"
trap 'rm -f "$temporary_settings"' EXIT

if grep -qE '^[[:space:]]*"material-code\.colors"[[:space:]]*:' "$settings"; then
    FRAGMENT="$fragment" perl -0pe '
        my $fragment = $ENV{"FRAGMENT"};
        s/[ \t]*"material-code\.colors"[ \t]*:\s*\{[^{}]*\}\s*,?/$fragment,/s;
    ' "$settings" > "$temporary_settings"
else
    FRAGMENT="$fragment" NEWLINE="$newline" perl -0pe '
        my $fragment = $ENV{"FRAGMENT"};
        my $newline = $ENV{"NEWLINE"};
        s/\A\{/{$newline$fragment,$newline/s;
    ' "$settings" > "$temporary_settings"
fi

chmod --reference="$settings" "$temporary_settings" 2>/dev/null || true
mv "$temporary_settings" "$settings"
trap - EXIT
