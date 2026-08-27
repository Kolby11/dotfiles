-- Frutiger Aero look: glassy, rounded, glossy. Copied to
-- ~/.config/hypr/custom/look.lua and require()d by custom/general.lua, which
-- runs after upstream hyprland.general, so these values win.

hl.config({
    decoration = {
        rounding = 22,
        rounding_power = 2,

        blur = {
            enabled = true,
            xray = true,
            special = false,
            new_optimizations = true,
            size = 9,
            passes = 4,
            brightness = 1.15,
            noise = 0.015,
            contrast = 1.1,
            vibrancy = 0.28,
            vibrancy_darkness = 0.2,
        },
        shadow = {
            enabled = true,
            range = 32,
            offset = { 0, 6 },
            render_power = 3,
            color = "rgba(0b3a4a55)",
        },
        dim_inactive = true,
        dim_strength = 0.08,
        active_opacity = 0.97,
        inactive_opacity = 0.92,
    },
})

-- Springy, wet-feeling window motion.
hl.curve("aeroSpring", {
    type = "bezier",
    points = { { 0.34, 1.56 }, { 0.24, 1.0 } },
})

hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4,   bezier = "aeroSpring", style = "popin 70%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 4,   bezier = "aeroSpring", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4.5, bezier = "aeroSpring", style = "slide" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,   bezier = "aeroSpring", style = "slidefade 15%" })
