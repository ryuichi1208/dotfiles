#!/bin/bash -e
# my setup script
# usage:
#   curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

function init() {
  mkdir -p ~/src ~/work ~/tmp ~/.vim/UltiSnips/ ~/.vim/undo
  timedatectl set-timezone Asia/Tokyo || :
  apt update && apt upgrade
}

function package_install() {
  apt install -y \
    linux-headers-$(uname -r)

  apt install -y \
    apache2-utils \
    autoconf \
    automake \
    bat \
    bpfcc-tools \
    bpftrace \
    build-essential \
    cargo \
    cproto \
    dstat \
    duf \
    exa \
    exuberant-ctags \
    fzf \
    gettext \
    git \
    golang \
    hexyl \
    iperf3 \
    jq \
    libacl1-dev \
    libgpm-dev \
    libgtk-3-dev \
    liblua5.2-dev \
    libluajit-5.1-dev \
    libncurses-dev \
    libpcre3-dev \
    libtinfo-dev \
    libxmu-dev \
    libxpm-dev \
    linux-tools-common \
    ltrace \
    locales-all \
    lua5.2 \
    luajit \
    net-tools \
    nodejs \
    peco \
    percona-toolkit \
    python3-dev \
    ripgrep \
    ruby-dev \
    shellcheck \
    strace \
    zlib1g-dev \
    zsh
}

function setup_cmd_tools() {
  if [[ ! -d ~/.zsh ]]; then
    mkdir -p ~/.zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    chsh -s /usr/local/bin/zsh
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi

  if [[ ! -d ~/z ]]; then
    git clone https://github.com/rupa/z.git ~/z
  fi

  if [[ ! -f  ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c "PlugInstall" -c "q" -c "q"
  fi
  
  if [[ ! -f ~/.asdf/bin/asdf ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
    source "$HOME/.asdf/asdf.sh"
    asdf plugin add kubectl https://github.com/Banno/asdf-kubectl.git
    asdf install kubectl 1.27.1
  fi
}

function setup_dotfiles() {
  if [[ ! -d ~/dotfiles ]]; then
    cd ~
    git clone https://github.com/ryuichi1208/dotfiles.git
    rm -f ~/.zshrc ~/.vimrc ~/.tmux.conf ~/.vim/UltiSnips/ ~/.gdbinit ~/.vim/UltiSnips/
    ln -s ~/dotfiles/linux/zshrc ~/.zshrc
    ln -s ~/dotfiles/linux/vimrc ~/.vimrc
    ln -s ~/dotfiles/linux/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/linux/.vim/go.snippets ~/.vim/UltiSnips/
    ln -s ~/dotfiles/linux/gdbinit ~/.gdbinit
  fi
}

function main() {
  init
  package_install
  setup_cmd_tools
  setup_dotfiles
}

date; time main
echo "SetUp Finish!!!!!!!!!!!!!!"
