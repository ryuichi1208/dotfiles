# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Zshrc.
if [[ -d "${ZDOTDIR:-$HOME/.zsh}" ]]; then
  source "${ZDOTDIR:-$HOME/.zsh/alias.zsh}"
  source "${ZDOTDIR:-$HOME/.zsh/functions.zsh}"
  source "${ZDOTDIR:-$HOME/.zsh/plugin.zsh}"
  source "${ZDOTDIR:-$HOME/.zsh/setopt.zsh}"
  source "${ZDOTDIR:-$HOME/.zsh/completion.zsh}"
fi


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/lib/python3.7/site-packages:$PATH"
source <(kubectl completion zsh)
# source <(helm completion zsh)
#source <(kubesec completion zsh)
