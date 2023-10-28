# Definition of env variables

## PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")

## Devkitpro
$env.DEVKITPRO = '/opt/devkitpro'
$env.DEVKITARM = '/opt/devkitpro/devkitARM'
$env.DEVKITPPC = '/opt/devkitpro/devkitPPC'


# Starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
