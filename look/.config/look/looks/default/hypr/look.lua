-- Default look: re-assert the stock illogical-impulse decoration values so
-- switching back from a heavier look (e.g. frutiger-aero) fully reverts.
-- This file is copied to ~/.config/hypr/custom/look.lua and require()d by
-- custom/general.lua.

hl.config({
    decoration = {
        rounding = 18,
        rounding_power = 2.5,
        blur = {
            enabled = true,
            xray = true,
            special = false,
            new_optimizations = true,
            size = 10,
            passes = 3,
            brightness = 1,
            noise = 0.05,
            contrast = 0.89,
            vibrancy = 0.5,
            vibrancy_darkness = 0.5,
        },
        shadow = {
            enabled = true,
            range = 20,
            offset = { 0, 2 },
            render_power = 10,
            color = "rgba(00000020)",
        },
        dim_inactive = true,
        dim_strength = 0.05,
    },
})
