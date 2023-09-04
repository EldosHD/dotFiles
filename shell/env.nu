$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")

# Starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu