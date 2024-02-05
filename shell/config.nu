$env.EDITOR = "/usr/bin/nvim"

$env.config = {
    # Sort alphabetically
    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    show_banner: false
}

# alias
alias l = exa -lag --git
alias e = exa -lag --git
alias ggs = grive -P -p ~/GoogleDrive
alias ca = cargo mommy
alias cacu = ca install-update -l
alias ucap = ca install-update -a
alias vim = nvim
alias v = nvim .

# broken TODO: fix
# alias pfv = pip freeze | sed "\"s/=.*//\""
# alias print-broken-symlinks = find -L . -type l

# Starship
use ~/.cache/starship/init.nu
