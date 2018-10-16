#下記コマンド実行で設定を反映
# $ cp -p .bashrc ~/
# $ source ~/.bashrc

# util command
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

# 環境変数
export HISTSIZE=100000
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
alias ll='ls -alFG'
alias ls='ls -FG'

if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi
