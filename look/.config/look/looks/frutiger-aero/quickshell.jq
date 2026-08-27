# Frutiger Aero look: turn on the shell's glass transparency and lean into the
# rounded/glossy bar. Applied with:  jq -f quickshell.jq config.json
.appearance.transparency.enable = true
| .appearance.transparency.backgroundTransparency = 0.20
| .appearance.transparency.contentTransparency = 0.45
| .appearance.fonts.expressive = "Comfortaa"
| .bar.cornerStyle = 1
| .bar.borderless = false
