if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

alias psg='ps aux | grep'
alias ll='ls -hlG'
alias la='ls -hlaG'
alias sl='ls'
alias c='clear'
alias 644='chmod 644'
alias 755='chmod 755'
alias fo="open ."

export LSCOLORS=gxfxcxdxbxegedabagacad
export PAGER=less
export RSYNC_RSH=ssh

HISTSIZE=50000
HISTFILESIZE=50000

umask 022
ulimit -c 0
