#!/bin/bash

function init() {
  mkdir -p ~/src ~/work ~/tmp ~/.vim/UltiSnips/ ~/.vim/undo
  timedatectl set-timezone Asia/Tokyo
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
    build-essential \
    cargo \
    cproto \
    dstat \
    duf \
    exa \
    exuberant-ctags \
    fzf \
    gettext \
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
    zlib1g-dev \
    zsh
}

function setup_cmd_tools() {
  mkdir -p ~/.zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  chsh -s /usr/local/bin/zsh
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  
  if [[ ! -d ~/z ]]; then
    git clone https://github.com/rupa/z.git ~/z
  fi
}

function setup_dotfiles() {
  if [[ ! -d ~/dotfiles ]]; then
    cd ~
    git clone https://github.com/ryuichi1208/dotfiles.git
  fi
}

function main() {
  init
  package_install
  setup_dotfiles
}

date; time main
