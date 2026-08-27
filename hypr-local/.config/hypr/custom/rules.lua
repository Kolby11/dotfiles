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

-- Match Kitty's 0.85 background_opacity. Kitty keeps its transparency inside
-- kitty.conf, while Zen and VS Code need a compositor-level opacity rule.
hl.window_rule({
    match = { class = "^zen$" },
    opacity = "0.85 0.85 0.85 override",
})

hl.window_rule({
    match = { class = "^(code|Code)$" },
    opacity = "0.85 0.85 0.85 override",
})

hl.window_rule({
    match = { class = "^Spotify$" },
    opacity = "0.90 0.90 0.90 override",
})
