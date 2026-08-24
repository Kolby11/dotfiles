#!/usr/bin/env bash

# End-4's switchwall.sh is kept in the upstream checkout.  This thin overlay
# makes it work with the Matugen version currently supplied by NixOS and with
# a Stow-managed shell config.

self="$(readlink -f "${BASH_SOURCE[0]}")"
script_dir="$(dirname "$self")"
repo_dir="$(cd "$script_dir/../../../../../.." && pwd)"
upstream_script="$repo_dir/hyprland-dotfiles/dots/.config/quickshell/ii/scripts/colors/switchwall.sh"
upstream_scripts_dir="$(dirname "$(dirname "$upstream_script")")"

if [[ ! -f "$upstream_script" ]]; then
    printf 'switchwall.sh: upstream script not found: %s\n' "$upstream_script" >&2
    exit 1
fi

# Wallpaper selection is launched detached by QuickShell. Serialize it so
# concurrent selections cannot race while writing Matugen output files or
# sending terminal control sequences.
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
lock_file="$runtime_dir/ii-switchwall.lock"
exec 9>"$lock_file"
if ! flock --exclusive --timeout 90 9; then
    printf 'switchwall.sh: timed out waiting for another wallpaper switch\n' >&2
    exit 1
fi

temporary_dir="$(mktemp -d "${TMPDIR:-/tmp}/ii-switchwall.XXXXXX")"
cleanup() {
    rm -rf -- "$temporary_dir"
}
trap cleanup EXIT

# Copy the complete scripts directory because the upstream script calls its
# sibling helpers using paths relative to its own location.
cp -a "$upstream_scripts_dir/." "$temporary_dir/"
patched_script="$temporary_dir/colors/switchwall.sh"

# Matugen 3.x does not have the Matugen 4 --source-color-index option. Keep
# the upstream behavior when a newer Matugen provides that option.
if ! matugen image --help 2>&1 | grep -q -- '--source-color-index'; then
    sed -i \
        's/^[[:space:]]*matugen_args=(--source-color-index 0)$/    matugen_args=()/' \
        "$patched_script"
fi

# jq + mv replaces the config file itself. Write through the path instead so
# both a Stow symlink and QuickShell's file watcher remain valid.
sed -i \
    's# && mv "\$SHELL_CONFIG_FILE.tmp" "\$SHELL_CONFIG_FILE"# \&\& cat "\$SHELL_CONFIG_FILE.tmp" > "\$SHELL_CONFIG_FILE" \&\& rm -f "\$SHELL_CONFIG_FILE.tmp"#g' \
    "$patched_script"

# The upstream helper broadcasts OSC color sequences to every /dev/pts. That
# can interrupt Fish's line editor while a command is being typed. Keep its
# generated files, but let Matugen's Kitty config hook perform the live reload.
II_SKIP_LIVE_TERMINAL_APPLY=1 exec bash "$patched_script" "$@"
