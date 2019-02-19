if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

# Normal Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

NC="\033[m"               # Color Reset
CR="$(echo -ne '\r')"
LF="$(echo -ne '\n')"
TAB="$(echo -ne '\t')"
ESC="$(echo -ne '\033')"

alias psg='ps aux | grep'
alias ll='ls -hlG'
alias la='ls -hlaG'
alias sl='ls'
alias c='clear'
alias 644='chmod 644'
alias 755='chmod 755'
alias fo='open .'
alias cp="cp -i"
alias mv="mv -i"
alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export LANG=en_US.UTF-8

export LSCOLORS=gxfxcxdxbxegedabagacad
export LESS="-FX -R"
export PAGER=less
export EDITOR=vim

export RSYNC_RSH=ssh

export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

umask 022
ulimit -c 0

# Comp Dir Only
complete -d cd

function psgrep() {
        ps aux | grep -v grep | grep "USER.*COMMAND"
        ps aux | grep -v grep | grep $1
}
