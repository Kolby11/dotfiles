# ~/.bashrc

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(oh-my-posh init bash --config ~/.config/omp/theme.json)"

# Auto-reload oh-my-posh on SIGUSR1 (triggered by matugen)
trap 'eval "$(oh-my-posh init bash --config ~/.config/omp/theme.json)"' USR1
# eval "$(starship init bash)"

eval "$(direnv hook bash)"
