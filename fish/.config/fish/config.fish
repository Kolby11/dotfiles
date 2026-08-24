# Personal Fish configuration.
#
# End-4's auto-Hypr.fish and fish_variables remain in the upstream Stow layer;
# this file is local so the upstream shell cannot replace our prompt setup.
if status is-interactive
    # No greeting
    set fish_greeting

    # Matugen refreshes the theme file while this shell is still alive.
    # Fish keeps Oh My Posh's renderer in a long-lived process, so re-source
    # the prompt before drawing the next prompt when the theme changed.
    function __refresh_omp_if_changed
        if test "$TERM" = "linux"
            return
        end
        set --local theme_path ~/.config/omp/theme.json
        if not test -f "$theme_path"
            return
        end
        set --local theme_stamp (stat -c '%Y:%s' -- "$theme_path" 2>/dev/null)
        if test -z "$theme_stamp"; or test "$theme_stamp" = "$__omp_theme_stamp"
            return
        end
        set --global __omp_theme_stamp "$theme_stamp"

        # Stop the old Oh My Posh serve process before replacing its functions.
        # This prevents one renderer from being leaked for every wallpaper
        # change.
        if functions -q _omp_serve_quit
            _omp_serve_quit
        end
        oh-my-posh init fish --config "$theme_path" | source
    end

    function __refresh_omp_before_prompt --on-event fish_prompt
        __refresh_omp_if_changed
    end

    # Use the same prompt engine and theme as Bash.
    if test "$TERM" != "linux"
        oh-my-posh init fish --config ~/.config/omp/theme.json | source
        set --global __omp_theme_stamp (stat -c '%Y:%s' -- ~/.config/omp/theme.json 2>/dev/null)
    end

    # Colors
    if test "$TERM" != "xterm-kitty"; and test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != "linux"
        alias ls 'eza --icons=auto'
    end
    if test "$TERM" = "xterm-kitty"
        alias ssh 'kitten ssh'
    end
end
