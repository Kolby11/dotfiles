#!/bin/bash
# gen-workspaces.sh
# Watches monitors.conf and regenerates workspaces.conf on change.
# Each "desktop" (key 1–DESKTOPS) switches all monitors simultaneously.

MONITORS_CONF="$HOME/.config/hypr/monitors.conf"
WORKSPACES_CONF="$HOME/.config/hypr/workspaces.conf"
DESKTOPS=4

generate() {
    mapfile -t monitors < <(grep '^monitor=' "$MONITORS_CONF" | awk -F'[=,]' '{print $2}')
    local n=${#monitors[@]}

    [[ $n -eq 0 ]] && { echo "gen-workspaces: no monitors found in $MONITORS_CONF" >&2; return 1; }

    {
        echo "# Workspaces - auto-generated from monitors.conf, do not edit manually"
        echo ""

        # Workspace assignments
        for ((d = 0; d < DESKTOPS; d++)); do
            for ((m = 0; m < n; m++)); do
                ws=$((d * n + m + 1))
                echo "workspace = $ws, monitor:${monitors[$m]}"
            done
            echo ""
        done

        # Desktop switch keybinds
        for ((d = 0; d < DESKTOPS; d++)); do
            local key=$((d + 1))
            echo -n "bind = \$mainMod CTRL, $key, exec, \\"
            echo ""
            for ((m = 0; m < n; m++)); do
                ws=$((d * n + m + 1))
                if [[ $m -lt $((n - 1)) ]]; then
                    echo "hyprctl dispatch workspace $ws; \\"
                else
                    echo "hyprctl dispatch workspace $ws"
                fi
            done
            echo ""
        done

    } > "$WORKSPACES_CONF"

    hyprctl reload &>/dev/null
    echo "gen-workspaces: regenerated with $n monitor(s), $DESKTOPS desktop(s)"
}

generate

inotifywait -m -e close_write,moved_to "$MONITORS_CONF" 2>/dev/null | while read -r _; do
    sleep 0.3  # debounce
    generate
done
