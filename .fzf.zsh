# Setup fzf
# ---------
if [[ ! "$PATH" == */home/valentin/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/valentin/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/valentin/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/valentin/.fzf/shell/key-bindings.zsh"
