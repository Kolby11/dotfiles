#!/usr/bin/env bash
set -euo pipefail

settings="$HOME/.config/Code/User/settings.json"
colors="$HOME/.config/matugen/vscode-colors.json"

[[ -f "$colors" ]] || exit 0

mkdir -p "$(dirname "$settings")"
if [[ ! -f "$settings" ]]; then
    printf '{\n}\n' > "$settings"
fi

# Keep generated settings in one marked block so the rest of the user's JSONC
# file, including comments and trailing commas, remains untouched.
fragment="$(sed '1d;$d' "$colors")"
fragment="${fragment},"
block=$'  // BEGIN MATUGEN_VSCODE\n'"${fragment}"$'\n  // END MATUGEN_VSCODE'
newline=$'\n'
if grep -q $'\r$' "$settings"; then
    newline=$'\r\n'
    block="${block//$'\n'/$'\r\n'}"
fi

temporary_settings="$(mktemp "${settings}.XXXXXX")"
trap 'rm -f "$temporary_settings"' EXIT

if grep -qF '// BEGIN MATUGEN_VSCODE' "$settings"; then
    BLOCK="$block" perl -0pe '
        my $block = $ENV{"BLOCK"};
        s/^[ \t]*\/\/ BEGIN MATUGEN_VSCODE.*?^[ \t]*\/\/ END MATUGEN_VSCODE[ \t]*\r?$/$block/sm;
    ' "$settings" > "$temporary_settings"
else
    BLOCK="$block" NEWLINE="$newline" perl -0pe '
        my $block = $ENV{"BLOCK"};
        my $newline = $ENV{"NEWLINE"};

        # Remove the old Material Code integration on first migration. The
        # fixed token palette below replaces its syntax highlighting settings.
        s/[ \t]*"material-code\.colors"[ \t]*:\s*\{[^{}]*\}\s*,?//s;
        s/^[ \t]*"material-code\.primaryColor"[^\r\n]*(?:\r?\n|$)//mg;
        s/^[ \t]*"workbench\.colorTheme"[^\r\n]*(?:\r?\n|$)//mg;

        my $prefix = "{" . $newline . $block . $newline;
        s/\A\{/$prefix/;
    ' "$settings" > "$temporary_settings"
fi

chmod --reference="$settings" "$temporary_settings" 2>/dev/null || true
mv "$temporary_settings" "$settings"
trap - EXIT
