lastExitCode='%?'
strZero='0'
NICE_PINK="#ff87ff"
NICE_GRAY="#585858"
SEGMENT_SEPARATOR=''

# Stolen from the Agnoster Theme
prompt_segment() {
  local bg fg

  # what? ($1 is the first agument and $2 the second)
  # sets bg to the first and fg to the second arg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  # if the current Background is set and the first arguemnt (bg) is not the current background
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    # print without newline
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi

  CURRENT_BG=$1
  # prints what is given
  [[ -n $3 ]] && print -n $3
}

rightTriangle() {
  print -n '\u276f'
}

location() {
  prompt_segment $NICE_GRAY $NICE_PINK ' %~ '
}

userName() {
  prompt_segment $NICE_PINK black ' %n '
}

  #  %(x.true-string.false-string)
endStr() {
  # print " lastExCo: $lastExitCode"
  # if [ $lastExitCode = $strZero ]
  # then
  #   echo "yeees"
  #   prompt_segment default $NICE_PINK " no " 
  # fi
  [[ $? -ne 0 ]] && prompt_segment black white ' no '
 
  prompt_segment black white '%f%k'
}

mainPrompt() {

}

prompt_precmd () {
  vcs_info
  PROMPT='$(location)$(userName)$(rightTriangle)%{$reset_color%}
$(rightTriangle)$(endStr) '

  RPROMPT='< jo'
}

prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_setup "$@"


