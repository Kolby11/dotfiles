#!/usr/bin/env bash

# E-ink reading mode: toggles the grayscale/paper-grain shader, dims the
# backlight, and hides the QuickShell bar for a distraction-free page.

SHADER="$HOME/.config/hypr/shaders/grayscale.glsl"

# hyprland/variables.lua exports qsConfig; fall back to the upstream default.
QS_CONFIG="${qsConfig:-ii}"

if hyprshade current | grep -q "grayscale"; then
    # Deactivate: drop the shader, restore brightness, bring the shell back.
    hyprshade off
    hyprctl reload
    brightnessctl set 60%

    # The activate branch kills the shell, so it has to be relaunched here or
    # the bar stays gone until the next Hyprland restart.
    if ! pgrep -x qs >/dev/null; then
        qs -c "$QS_CONFIG" >/dev/null 2>&1 &
        disown
    fi
else
    # Activate: paper shader, dim backlight, no bar.
    hyprshade on "$SHADER"
    pkill -x qs
    brightnessctl set 37%
fi
