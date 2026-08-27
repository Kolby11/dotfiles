# Default look: restore stock illogical-impulse appearance keys. Applied with
#   jq -f quickshell.jq config.json
.appearance.transparency.enable = false
| .appearance.transparency.backgroundTransparency = 0.11
| .appearance.transparency.contentTransparency = 0.57
| .appearance.fonts.expressive = "Space Grotesk"
| .bar.cornerStyle = 1
