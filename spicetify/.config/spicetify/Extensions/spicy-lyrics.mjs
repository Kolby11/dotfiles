// Upstream loader kept in the dotfiles layer; the Nix package uses the pinned
// Spicy Lyrics source directly for reproducible builds.
import("https://cdn.jsdelivr.net/gh/Spikerko/spicy-lyrics@main/builds/v1.1/entrypoint.mjs");
