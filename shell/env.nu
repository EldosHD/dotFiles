# Definition of env variables

## PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/go/bin")

## EPICS
$env.EPICS_BASE = ([$env.HOME, '/EPICS/epics-base'] | str join)
$env.EPICS_HOST_ARCH = ([$env.EPICS_BASE, '/startup/EpicsHostArch'] | str join)
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.EPICS_BASE)/bin/(/bin/sh ($env.EPICS_HOST_ARCH))")

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
