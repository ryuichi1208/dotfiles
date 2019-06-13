# -----------------------------
# Alias
# -----------------------------

# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# 固有
alias nvim="~/nvim-osx64/bin/nvim"
alias vim="nvim"

# ls
alias ls='ls -G'
alias la='ls -la -G'
alias ll='ls -l -G'
alias lt='ls -lrt -G'
alias lc='clear && ll'

# cd
alias c='cd ~/'
alias ..='cd ..'

# dotfiles
alias vz='vim ~/.zshrc'
alias vn='vim ~/.config/nvim/dein.toml'

# Git
alias gs='git status'
alias gd='git diff'

# Docker
alias d='docker'
alias dc='docker-compose'
