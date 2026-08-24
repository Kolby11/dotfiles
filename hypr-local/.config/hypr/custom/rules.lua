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
