# setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

setopt EXTENDED_GLOB
setopt MULTIOS
setopt NO_CLOBBER

setopt AUTO_RESUME
setopt INTERACTIVE_COMMENTS
setopt LONG_LIST_JOBS
setopt NOTIFY
setopt NO_BG_NICE
setopt NO_CHECK_JOBS
WORDCHARS=${WORDCHARS//[\/]}


HISTFILE="${ZDOTDIR:-${HOME}}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

preexec() { print -Pn "\e]0;$(hostname)\a" }

if (( terminfo[colors] >= 8 )); then
  if (( ${+commands[dircolors]} )); then
    alias ls='ls --group-directories-first --color=auto'
  else
    alias ls='ls -G'
  fi

  if [[ ${OSTYPE} == openbsd* ]]; then
    (( ${+commands[ggrep]} )) && alias grep='ggrep --color=auto'
  else
   alias grep='grep --color=auto'
  fi

  if [[ ${PAGER} == 'less' ]]; then
    (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
    (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
    (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
    (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\E[0m'      # Ends standout-mode.
    (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
    (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
    (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
  fi
fi

alias ll='ls -lh'         # long format and human-readable sizes
alias l='ll -A'           # long format, all files
[[ -n ${PAGER} ]] && alias lm="l | ${PAGER}" # long format, all files, use pager
alias lr='ll -R'          # long format, recursive
alias lk='ll -Sr'         # long format, largest file size last
alias lt='ll -tr'         # long format, newest modification time last
alias lc='lt -c'          # long format, newest status change (ctime) last

bindkey -e
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[ ._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.so|*.pyc'
zstyle ':completion:*:*sh:*:' tag-order files

autoload -U colors && colors
precmd() {
    __git_branch="`git rev-parse --abbrev-ref HEAD 2>/dev/null`"
    [[ -n $__git_branch ]] && __git_branch=" ${__git_branch}"
}
setopt PROMPT_SUBST
# PROMPT='%K{238}%(?:%F{112}:%F{9})${LOCAL_MACHINE_NAME:-> }%B%F{4}%c%b%F{244}${__git_branch}%f %{$reset_color%} '
PROMPT=$'%(?:%F{112}:%F{9})${LOCAL_MACHINE_NAME:-> }%B%F{4}%c%b%F{244}${__git_branch}%f%{$reset_color%} '
