# ~/.bashrc

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(oh-my-posh init bash --config ~/.config/omp/theme.json)"

# Auto-reload oh-my-posh on SIGUSR1 (triggered by matugen)
trap 'eval "$(oh-my-posh init bash --config ~/.config/omp/theme.json)"' USR1
# eval "$(starship init bash)"

eval "$(direnv hook bash)"
export PATH="/nix/store/hkvwiwp6vdy0z1yqq5giinvbxj4h8516-nodejs-24.11.1/bin:$PATH"
export PATH="$HOME/.local/share/npm-global/bin:$PATH"
