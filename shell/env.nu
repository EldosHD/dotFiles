# Definition of env variables

## PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/go/bin")

## Devkitpro
$env.DEVKITPRO = '/opt/devkitpro'
$env.DEVKITARM = '/opt/devkitpro/devkitARM'
$env.DEVKITPPC = '/opt/devkitpro/devkitPPC'

# Cargo mommy
$env.CARGO_MOMMYS_MOODS = 'chill/ominous/thirsty'
$env.CARGO_MOMMYS_LITTLE = 'boy/girl'

# Starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
