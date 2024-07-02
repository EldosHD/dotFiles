$env.EDITOR = "/usr/bin/nvim"

$env.config = {
    # Sort alphabetically
    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    show_banner: false
    keybindings: [
        {
            name: clear 
            modifier: control
            keycode: char_j 
            mode: emacs
            event: [
                { send: ClearScreen }
            ]
        },
        {
            name: clear 
            modifier: control
            keycode: char_l
            mode: emacs
            event: [
                { send: HistoryHintComplete}
            ]
        }
    ]
}

# alias
alias l = eza -lag --git
alias e = eza -lag --git
alias ca = cargo mommy
alias cacu = ca install-update -l
alias ucap = ca install-update -a
alias vim = nvim
alias v = nvim .
alias cbat = bat --decorations never

# completions
use ~/nu_scripts/custom-completions/cargo/cargo-completions.nu *
use ~/nu_scripts/custom-completions/git/git-completions.nu *
use ~/nu_scripts/custom-completions/glow/glow-completions.nu *
use ~/nu_scripts/custom-completions/make/make-completions.nu *
use ~/nu_scripts/custom-completions/rustup/rustup-completions.nu *
use ~/nu_scripts/custom-completions/typst/typst-completions.nu *
use ~/nu_scripts/custom-completions/zellij/zellij-completions.nu *

# Starship
use ~/.cache/starship/init.nu
