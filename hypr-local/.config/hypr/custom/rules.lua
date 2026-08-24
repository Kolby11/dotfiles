-- MESH publishes surface-local backdrop-filter regions through the KDE blur
-- protocol. Hyprland additionally requires an explicit layer rule before it
-- will blur layer surfaces and their promoted popup children.
hl.layer_rule({
    match = { namespace = "^@mesh/.*:blur$" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0,
    xray = false,
})

-- Match the translucent treatment used by Zen. Kitty keeps its transparency
-- inside kitty.conf, while VS Code needs a compositor-level opacity rule.
hl.window_rule({
    match = { class = "^zen$" },
    opacity = "0.92 0.92 0.92 override",
})

hl.window_rule({
    match = { class = "^(code|Code)$" },
    opacity = "0.92 0.92 0.92 override",
})
