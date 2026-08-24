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

## Fastfetch themes

Source: <https://github.com/LierB/fastfetch>
