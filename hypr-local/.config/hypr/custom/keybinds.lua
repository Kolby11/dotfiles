-- Local bindings carried forward from the previous hyprland.conf setup.
--
-- The upstream Lua bindings are loaded first. Remove only the shortcuts that
-- the local config intentionally overrides, then install the local actions.

local function replace_bind(keys, dispatcher, options)
    hl.unbind(keys)
    return hl.bind(keys, dispatcher, options)
end

local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function global(shortcut)
    return hl.dsp.global(shortcut)
end

-- User config
hl.bind("CTRL + SUPER + Slash", exec("xdg-open ~/.config/illogical-impulse/config.json"),
    { description = "Edit shell config" })
hl.bind("CTRL + SUPER + ALT + Slash", exec("xdg-open ~/.config/hypr/custom/keybinds.lua"),
    { description = "Edit extra keybinds" })

-- Apps and launchers
-- SUPER+T is left to upstream, which binds it to the `terminal` variable
-- (kitty first, see custom/variables.lua). It used to be replace_bind'd to
-- thunar, which is not installed -- SUPER+E already opens a file manager.
replace_bind("SUPER + B", exec("firefox"), { description = "App: Browser" })
replace_bind("SUPER + W", exec("firefox"), { description = "App: Browser" })
replace_bind("SUPER + E", exec("pcmanfm-qt"), { description = "App: File manager" })
hl.bind("SUPER + Grave", exec("kitty"), { description = "App: Terminal" })
hl.bind("SUPER + SHIFT + V", exec("pavucontrol"), { description = "App: Volume control" })
replace_bind("CTRL + SUPER + S", exec("spotify"), { description = "App: Music" })

-- The old config deliberately attached more than one launcher to SUPER+D.
hl.unbind("SUPER + D")
hl.bind("SUPER + D", exec("$rofiScripts/launcher"))
hl.bind("SUPER + D", global("caelestia:launcher"))
hl.bind("SUPER + D", exec("wofi --show drun"), { description = "App: Launcher" })

-- Shell controls
hl.bind("SUPER + Space", global("workspace, special"))
hl.bind("SUPER + Comma", exec("qs -p /home/kolby/kshell ipc call sidebarLeft toggle"))
hl.bind("SUPER + Period", exec("qs -p /home/kolby/kshell ipc call sidebarRight toggle"))

for _, key in ipairs({
    "mouse:272", "mouse:273", "mouse:274", "mouse:275",
    "mouse:276", "mouse:277", "mouse_up", "mouse_down",
}) do
    hl.bind("SUPER + " .. key, global("caelestia:launcherInterrupt"),
        { ignore_mods = true, non_consuming = true })
end

-- Session and screenshots
replace_bind("CTRL + ALT + Delete", hl.dsp.exit())
replace_bind("SUPER + M", exec("wlogout --protocol layer-shell"))
hl.bind("SUPER + SHIFT + Q", exec("$deskScripts/wlogout.sh"))
hl.bind("SUPER + SHIFT + Q", exec("swaylock"), { description = "Session: Lock screen" })
replace_bind("SUPER + SHIFT + R", exec("hyprctl reload"), { description = "Hyprland: Reload config" })
replace_bind("SUPER + SHIFT + S", exec("hyprshot -m region --clipboard-only"),
    { description = "Utilities: Take a screenshot" })
hl.bind("SUPER + R", exec("/home/kolby/.config/hypr/shaders/reading_mode.sh"),
    { description = "Screen: Reading mode" })

-- Window state and groups
replace_bind("SUPER + Q", hl.dsp.window.close(), { description = "Window: Close" })
replace_bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = "Window: Fullscreen" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }),
    { description = "Window: Float/Tile" })
replace_bind("SUPER + ALT + F", exec("hyprctl dispatch workspaceopt allfloat"),
    { description = "Workspace: Toggle all floating" })
replace_bind("SUPER + P", hl.dsp.window.pseudo({ action = "toggle" }),
    { description = "Window: Pseudotile" })
replace_bind("SUPER + S", hl.dsp.layout("togglesplit"), { description = "Window: Toggle split" })
replace_bind("SUPER + G", hl.dsp.group.toggle(), { description = "Window: Toggle group" })
hl.bind("CTRL + SUPER + Tab", hl.dsp.group.next(), { description = "Window: Next in group" })
hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { description = "Window: Cycle next" })
hl.bind("CTRL + ALT + Tab", hl.dsp.window.alter_zorder({ mode = "top" }),
    { description = "Window: Bring active to top" })

-- Direct workspace selection and window movement
for i = 1, 10 do
    local key = tostring(i % 10)
    replace_bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Vim-style focus, move, and resize
local directions = {
    h = { direction = "l", resize = {-100, 0} },
    l = { direction = "r", resize = {100, 0} },
    k = { direction = "u", resize = {0, -100} },
    j = { direction = "d", resize = {0, 100} },
}

for key, values in pairs(directions) do
    replace_bind("SUPER + " .. key, hl.dsp.focus({ direction = values.direction }))
    replace_bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = values.direction }))
    hl.bind("CTRL + SUPER + " .. key,
        hl.dsp.window.resize({ x = values.resize[1], y = values.resize[2], relative = true }))
end

-- Mouse move/resize are already present upstream and intentionally remain
-- alongside the launcher-interrupt binds above.

-- Brightness
replace_bind("XF86MonBrightnessUp", global("caelestia:brightnessUp"), { locked = true })
replace_bind("XF86MonBrightnessDown", global("caelestia:brightnessDown"), { locked = true })

-- Audio and media
replace_bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true })
replace_bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true })
hl.bind("CTRL + SUPER + Space", global("caelestia:mediaToggle"), { locked = true })
replace_bind("XF86AudioPlay", global("caelestia:mediaToggle"), { locked = true })
replace_bind("XF86AudioPause", global("caelestia:mediaToggle"), { locked = true })
hl.bind("CTRL + SUPER + Equal", global("caelestia:mediaNext"), { locked = true })
replace_bind("XF86AudioNext", global("caelestia:mediaNext"), { locked = true })
hl.bind("CTRL + SUPER + Minus", global("caelestia:mediaPrev"), { locked = true })
replace_bind("XF86AudioPrev", global("caelestia:mediaPrev"), { locked = true })
hl.bind("XF86AudioStop", global("caelestia:mediaStop"), { locked = true })
