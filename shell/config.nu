$env.PATH = ($env.PATH | append "$env.HOME/.cargo/bin")

$env.EDITOR = "/usr/bin/nvim"

$env.config = {
    # Sort alphabetically
    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    show_banner: false
}

# Starship
use ~/.cache/starship/init.nu