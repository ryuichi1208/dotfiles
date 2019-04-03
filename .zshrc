autoload colors
colors

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

setopt correct

PROMPT='%n@%m:%~# '

setopt HIST_IGNORE_DUPS

alias ls='ls --color=auto'
alias ll='ls -hlG --color=auto'

setopt auto_cd
