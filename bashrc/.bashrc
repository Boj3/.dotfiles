#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


# Load Angular CLI autocompletion.
source <(ng completion script)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
