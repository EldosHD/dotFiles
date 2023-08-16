### Update Path ###

# Rust binaries
export PATH="$HOME/.cargo/bin:$PATH"

### Aliases ###
alias l="exa -lag"
alias e="exa -lag"
alias ggs="grive -P -p ~/GoogleDrive"
alias nrp="cargo init && cargo clippy --fix -- \
-W clippy::pedantic \
-W clippy::nursery \
-W clippy::unwrap_used \
-W clippy::expect_used"
alias pfv="pip freeze | sed \"s/=.*//\""
alias print-broken-symlinks="find -L . -type l"


### Zellij ###
eval "$(zellij setup --generate-auto-start zsh)"

### Starship ###
eval "$(starship init zsh)"