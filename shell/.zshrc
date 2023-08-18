### Update Path ###

# Rust binaries
export PATH="$HOME/.cargo/bin:$PATH"

### Aliases ###
alias l="exa -lag"
alias e="exa -lag"
alias ggs="grive -P -p ~/GoogleDrive"
alias clippy-setup="cargo clippy --fix -- \
-W clippy::pedantic \
-W clippy::nursery \
-W clippy::unwrap_used \
-W clippy::expect_used"
alias pfv="pip freeze | sed \"s/=.*//\""
alias print-broken-symlinks="find -L . -type l"

### Plugins with oh-my-zsh ###
export ZSH="$HOME/.oh-my-zsh"

plugins=(git sudo)

# TODO: overwrite the l alias
source $ZSH/oh-my-zsh.sh

### Zellij ###
eval "$(zellij setup --generate-auto-start zsh)"

### Starship ###
eval "$(starship init zsh)"
