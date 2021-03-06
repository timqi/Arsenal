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

bindkey -e
autoload -Uz compinit
compinit -C
zmodload zsh/complist
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey -M menuselect '/' history-incremental-search-forward


autoload -U colors && colors
export LS_COLORS="$LS_COLORS:ow=34;4"

precmd() {
    [[ -e ".git" ]] && __git_branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null` &&\
        [[ -n $__git_branch ]] && __git_branch=" $__git_branch" || __git_branch=""
}

setopt PROMPT_SUBST
LOCAL_MACHINE_NAME=`hostname`
PROMPT=$'%(?:%F{112}:%F{9})${LOCAL_MACHINE_NAME:->} %B%F{4}%c%b%F{244}${__git_branch}%f%{$reset_color%} %# '
