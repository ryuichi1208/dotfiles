# -----------------------------
#Lang
# -----------------------------
export LANG=ja_JP.UTF-8

# -----------------------------
# history
# -----------------------------
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history

# -----------------------------
# Environment variable
# -----------------------------
# エディタをvimに設定
export EDITOR=vim
export VISUAL='vim'

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# rsysncでsshを使用する
export RSYNC_RSH=ssh

# コンテナのビルダーを指定
export DOCKER_BUILDKIT=1

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# python関連
export PATH="$PYENV_ROOT/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"

# Go関連
if which go > /dev/null 2>&1  ; then
  export CGO_ENABLED=1
  export GOPATH=$HOME/dev/go
  export PATH=$PATH:$(go env GOROOT)/bin:$GOPATH/bin
fi

#fzf関連
if [ -f ~/.fzf.zsh ] ; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
  export FZF_DEFAULT_OPTS="--height 40% --reverse --border --preview 'ls -la {}'"
  export FZF_LEGACY_KEYBINDINGS=0

fi

: << EOF
DIRACTION_EDITOR=vi
DIRACTION_DEF_FILE=/Users/JPZ2046/.diractions
DIRACTION_BROWSER=
DIRACTION_AUTO_CONFIG=true
ENHANCD_DIR=/Users/JPZ2046/.enhancd
ENHANCD_DISABLE_DOT=0
ENHANCD_DISABLE_HYPHEN=0
ENHANCD_DISABLE_HOME=0
ENHANCD_DOT_ARG=..
ENHANCD_HYPHEN_ARG=-
ENHANCD_HYPHEN_NUM=10
ENHANCD_HOME_ARG=
ENHANCD_DOT_SHOW_FULLPATH=0
ENHANCD_USE_FUZZY_MATCH=1
ENHANCD_ROOT=/Users/JPZ2046/.zplug/repos/b4b4r07/enhancd
ENHANCD_COMMAND=cd
ENHANCD_FILTER=fzy:fzf-tmux:fzf:peco:percol:gof:pick:icepick:sentaku:selecta
ENHANCD_AWK=awk
EDITOR=vim
VISUAL=vim
RSYNC_RSH=ssh
DOCKER_BUILDKIT=1
PYTHONDONTWRITEBYTECODE=1
PYENV_ROOT=/Users/JPZ2046/.pyenv
CGO_ENABLED=1
GOPATH=/Users/JPZ2046/dev/go
FZF_DEFAULT_COMMAND=rg --files --hidden --glob "!.git"
FZF_DEFAULT_OPTS=--height 40% --reverse --border
FZF_LEGACY_KEYBINDINGS=0
EOF

# -----------------------------
# General
# -----------------------------
# 色を使用
autoload -Uz colors ; colors

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# emacsキーバインド
bindkey -e

# フローコントロールを無効にする
setopt no_flow_control

# ワイルドカード展開を使用する
setopt extended_glob

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# ビープ音を鳴らさないようにする
setopt no_beep

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の入力のみで移動する
setopt auto_cd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# 8bit文字を有効にする
setopt print_eight_bit

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# パスの最後のスラッシュを削除しない
setopt noautoremoveslash

# -----------------------------
# Prompt
# -----------------------------
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "%F{black}%r:%b"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
