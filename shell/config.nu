$env.PATH = ($env.PATH | append "$env.HOME/.cargo/bin")

$env.EDITOR = "/usr/bin/nvim"

$env.config = {
    # Sort alphabetically
    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    show_banner: false
}

# alias
alias l = exa -lag
alias e = exa -lag
alias ggs = grive -P -p ~/GoogleDrive

# broken TODO: fix
# alias pfv = pip freeze | sed "\"s/=.*//\""
# alias print-broken-symlinks = find -L . -type l

# Starship
use ~/.cache/starship/init.nu