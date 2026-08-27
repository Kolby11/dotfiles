-- Personal general Hyprland settings.
--
-- The active "look" theme (see the `look` CLI / look/ Stow package) writes its
-- decoration, blur, shadow and animation overrides to custom/look.lua, which
-- is generated and not tracked. Load it if present; a bare desktop with no
-- look selected just keeps the upstream illogical-impulse defaults.
-- Drop any cached copy so `hyprctl reload` re-reads an edited look.lua.
package.loaded["custom.look"] = nil
pcall(require, "custom.look")
