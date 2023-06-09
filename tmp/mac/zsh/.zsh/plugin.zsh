# -----------------------------
# Plugin
# -----------------------------
# zplugが無ければインストール
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを有効化する
source ~/.zplug/init.zsh

# プラグインList
zplug "adrieanKhisbe/diractions"
zplug "b4b4r07/enhancd", use:init.sh
zplug "b4b4r07/zsh-gomi"
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
zplug "nnao45/zsh-kubectl-completion"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# インストールしていないプラグインをインストール
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

PATH="/usr/local/opt/llvm/bin:$PATH"
