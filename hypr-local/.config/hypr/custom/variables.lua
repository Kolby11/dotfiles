-- Local variable overrides.
--
-- Sourced by hyprland/keybinds.lua right after hyprland/variables.lua and before
-- the binds are declared, so overrides here reach SUPER+Return / SUPER+T /
-- CTRL+ALT+T. This is the upstream-intended override point -- note it is NOT
-- listed in hyprland.lua, which is easy to misread as it being unused.

-- Prefer kitty. Upstream lists 'foot' first, which is why those binds opened foot.
terminal = "~/.config/hypr/hyprland/scripts/launch_first_available.sh 'kitty -1' 'foot' 'alacritty' 'wezterm' 'konsole' 'kgx' 'uxterm' 'xterm'"
