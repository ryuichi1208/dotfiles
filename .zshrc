# 色を使用
autoload -Uz colors ; colors

# プロンプトカスタマイズ
PROMPT='%F{cyan}%n@%m%f:%~# '

# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# emacsキーバインド
bindkey -e

# viキーバインド
#bindkey -e

# history関連
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# ヒストリーに重複を表示しない
setopt histignorealldups

# 他のターミナルとヒストリーを共有
setopt share_history

# すでにhistoryにあるコマンドは残さない
setopt hist_ignore_all_dups

# historyに日付を表示
alias h='fc -lt '%F %T' 1'


# 自動補完を有効にする
autoload -Uz compinit ; compinit

# 補完の選択を楽にする
zstyle ':completion:*' menu select


# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# エイリアス
alias lst='ls -ltr --color=auto'
alias ls='ls  --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias so='source'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'
