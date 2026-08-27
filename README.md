# Dotfiles

Personal configuration files managed independently from NixOS with GNU Stow.
NixOS/Home Manager installs applications and services; this repository owns the
mutable configuration files linked into `$HOME`.

End-4's Illogical Impulse shell is kept as a separate checkout at
`~/.config/dotfiles/hyprland-dotfiles`. Its upstream Hyprland and QuickShell
files are Stow-linked as a read-only upstream layer, while this repository's
packages are applied afterward. Personal packages such as `kitty`, `matugen`,
`wlogout`, and `hypr-local` are excluded from the upstream layer and therefore
remain authoritative.

The local Fish configuration owns the prompt integration. Fish uses the same
Oh My Posh theme as Bash; End-4's other Fish support files remain in the
upstream layer.

## Bootstrap

After cloning the repository to `~/.config/dotfiles`, install the management
command and apply every package:

```bash
cd ~/.config/dotfiles
stow --target="$HOME" stow-manager
dotfiles apply
```

## Daily use

Edits made through `~/.config` normally modify the linked repository file
directly and need no deployment step. Restow after adding, deleting, or renaming
files:

```bash
dotfiles check             # Preview changes or conflicts
dotfiles apply             # Restow all packages
dotfiles apply hypr-local kitty  # Restow selected packages
dotfiles status            # Git status plus a Stow dry run
```

To clone or fast-forward End-4's checkout and restow both layers:

```bash
dotfiles upstream-update
```

Home Manager runs that command after each switch when the Nix configuration is
used. It performs a fast-forward-only `git pull` and refuses to overwrite local
changes in the upstream checkout.

To update this repository from its configured Git remote and restow it:

```bash
dotfiles update
```

Both update commands refuse to pull over local changes. The first migration
backs up regular files that the old Home Manager copy step left in place under
`~/.config/dotfiles-backup.*`; pre-existing local files are preserved under
`~/.config/dotfiles-local-backup.*` before their Stow links are installed.

## Look themes

`look` swaps whole-aesthetic presets ("looks") on the running desktop, not just
colours. Matugen still derives every hue from the wallpaper; a look only changes
*form* - Spicetify player styling, kitty opacity/padding/blur, Hyprland
decoration and animations, and the quickshell bar style.

```bash
look list                  # Available looks (* marks the active one)
look set frutiger-aero     # Apply a look now - no app restarts
look set default           # Back to the stock Matugen desktop
look current               # Print the active look
```

Looks live in `look/.config/look/looks/<name>/`:

| File                     | Purpose |
|--------------------------|---------|
| `look.toml`              | Name, description, optional Matugen `scheme` / `mode`, and `spicetify_theme` / `spicetify_color_scheme` (which theme to select in `config-xpui.ini`) |
| `matugen/matugen-*.{css,ini,conf}` | Aesthetic overrides for the templates routed through `~/.config/matugen/templates/active/` (Matugen Spicetify CSS + palette, kitty, and the Liquify tint). Missing files fall back to `looks/base/` |
| `kitty/look.conf`        | Non-colour kitty knobs; `kitty.conf` `include`s it as `current-look.conf` |
| `hypr/look.lua`          | `hl.config{}` decoration/blur/shadow/animation overrides; copied to `~/.config/hypr/custom/look.lua` and `require`d by `custom/general.lua` |
| `quickshell.jq`          | `jq` edits applied to `~/.config/illogical-impulse/config.json` |
| `wallpaper.txt`          | Palette-seeding wallpaper path; if the file is missing the current wallpaper is kept |

`matugen/config.toml` points the Spicetify and kitty templates at
`~/.config/matugen/templates/active/`, which `look set` populates from the
chosen look (or `looks/base/`). After `dotfiles apply look`, run `look set
default` once to seed `active/` and the generated look files.

### Spicetify themes

- **default** -> the built-in `Matugen` theme (`Themes/Matugen/`, flat, palette from `matugen-spicetify.{css,ini}`).
- **frutiger-aero** -> [Liquify](https://github.com/NMWplays/Liquify) (AGPL-3.0), vendored pinned at
  `Themes/Liquify/` (`user-base.css`, `theme.js`, `color.ini`). `look set` writes the wallpaper
  tint to `_look-tint.css` (from `matugen-liquify.css`) and stitches `user-base.css + _look-tint.css`
  into the `user.css` Spicetify loads. Liquify's in-app settings panel (gear icon) controls its
  background image, blur and transparency; its `theme.js` does GitHub update checks and optional
  Google-translate/romaji lookups. Update it by re-vendoring a newer commit into `Themes/Liquify/`.

## Fastfetch themes

Source: <https://github.com/LierB/fastfetch>
