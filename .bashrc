#下記コマンド実行で設定を反映
# $ cp -p .bashrc ~/
# $ source ~/.bashrc

# エイリアス
alias ls='ls -FG'
alias ll='ls -alFG'
alias cp='cp -i'
alias sc='screen'

# 環境変数
export PS1='\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\]'
export HISTSIZE=100000
export LC_ALL='ja_JP.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
