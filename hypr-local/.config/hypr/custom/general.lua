-- Personal general Hyprland settings.
--
-- This file is Stow-owned. Two generated, untracked siblings are loaded here
-- when they exist:
--   custom/look.lua     the active "look" theme's decoration/blur/animation
--                       overrides (written by the `look` CLI)
--   custom/plugins.lua  Nix-built Hyprland plugin loads (written by Home
--                       Manager's writeHyprlandNixOverrides activation)
-- Both are optional; with neither present the upstream illogical-impulse
-- defaults stand. `package.loaded[...] = nil` lets `hyprctl reload` re-read an
-- edited file instead of returning the cached module.

package.loaded["custom.look"] = nil
pcall(require, "custom.look")

package.loaded["custom.plugins"] = nil
pcall(require, "custom.plugins")
