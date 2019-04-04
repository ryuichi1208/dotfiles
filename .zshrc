# 色を使用
autoload -Uz colors ; colors

# プロンプトカスタマイズ
PROMPT='%F{cyan}%n@%m%f:%~# '

# エディタをvimに設定
export EDITOR=vim

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8

# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# viキーバインド
bindkey -v

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

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# ワイルドカード展開を使用する
setopt extended_glob

# 自動補完を有効にする
autoload -Uz compinit ; compinit

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
setopt list_types

# 色の設定
#export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色設定
#export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# ビープ音を鳴らさないようにする
#setopt no_beep

# ディレクトリ名の入力のみで移動する 
setopt auto_cd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# エイリアス
alias lst='ls -ltr --color=auto'
alias ls='ls --color=auto'
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

# Macports
case "${OSTYPE}" in
  darwin*)
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
  ;;
esac
