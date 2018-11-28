#下記コマンド実行で設定を反映
# $ cp -p .bashrc ~/
# $ source ~/.bashrc

if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

### base ###
export PLATFORM=$(uname -s)
umask 022
ulimit -c 0
#shopt -s cdspell
#shopt -s checkwinsize

### alias ###
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ls='ls -FG'
alias ll='ls -alFG'
alias cp='cp -i'
alias sc='screen'
alias chrome='open -a Google\ Chrome'
alias shl='exec $SHELL -l'
alias zhl='exec zsh -l'
alias pg='ps aux | grep'
alias pa='ps aux | tail -n +2| fzf'
alias pk="pa | awk '{print \$2}' | xargs kill -9"
alias rmi='rm -i'
alias mvi='mv -i'
alias cpi='cp -i'
alias lld='ls -ld'
alias ..='cd ..'
alias 644='chmod 644'
alias 755='chmod 755'
alias ox='od -Ax -tx1'

### env ###
export HISTSIZE=100000
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
export PAGER=less
export RSYNC_RSH=ssh
export GOPATH=$HOME/code/go

### AWS Aliases ###
alias adil='aws describe-instances'
function adi-ctl {
  adil $@ |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adi='adi-ctl'
function adia-ctl {
  adil $@ --region ap-northeast-1 |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adia='adia-ctl'
function adie-ctl {
  adil $@ --region eu-west-1 |awk -F "|" '{ print $2 " " $6 " " $9 " " $12 " " $13; }'
}
alias adie='adie-ctl'
alias adg='aws describe-groups'

# rg > pt > ag > ack
alias ack=rg

# hub > git
[ ! $(which hub) == "" ] && eval "$(hub alias -s)"
alias g='git'
alias gbranch='git rev-parse --abbrev-ref HEAD'
function gclone {
  git clone ssh://git@github.com/$1
}
