$env.EDITOR = "/usr/bin/nvim"

$env.config = {
    # Sort alphabetically
    rm: {
        always_trash: true # always act as if -t was given. Can be overridden with -p
    }

    show_banner: false
    keybindings: [
        {
            name: clear 
            modifier: control
            keycode: char_j 
            mode: emacs
            event: [
                { send: ClearScreen } # set clear screen to C-j
            ]
        },
        {
            name: clear 
            modifier: control
            keycode: char_l
            mode: emacs
            event: [
                { send: HistoryHintComplete} #  set autocomplete to C-l
            ]
        }
    ]
}

# alias
alias l = eza -lag --git --icons
alias e = l
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
