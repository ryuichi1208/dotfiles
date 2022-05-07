#!/bin/bash
# my setup script
# usage:
#   curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

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
  
  if [[ ! -d ~/.cache/dein ]]; then
    mkdir -p ~/.cache/dein
    cd ~/.cache/dein
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein
  fi
}

function setup_dotfiles() {
  if [[ ! -d ~/dotfiles ]]; then
    cd ~
    git clone https://github.com/ryuichi1208/dotfiles.git
    rm -f ~/.zshrc && ln -s ~/dotfiles/linux/zshrc ~/.zshrc
    ln -s ~/dotfiles/linux/vimrc ~/.vimrc
    ln -s ~/dotfiles/linux/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/linux/.vim/go.snippets ~/.vim/UltiSnips/
    ln -s ~/dotfiles/linux/gdbinit ~/.gdbinit
  fi
}

function install_k8s_tools() {
  cd ~/tmp

  type stern || \
    {
      wget https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 && \
      chmod 755 stern_linux_amd64 && \
      mv stern_linux_amd64 /usr/local/bin/stern
    }

  type kubectx || \
    {
      wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz && \
      tar -xvf kubectx_v0.9.4_linux_x86_64.tar.gz && \
      mv kubectx /usr/local/bin/
    }

  type kubens || \
    {
      wget https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz && \
      tar -xvf kubens_v0.9.4_linux_x86_64.tar.gz && \
      mv kubens /usr/local/bin/
    }
    
  type k9s || \
    {
      wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz && \
      tar -xvf k9s_Linux_x86_64.tar.gz
      mv k9s /usr/local/bin/
    }
    
  type etcdctl || \
    {
      wget https://github.com/etcd-io/etcd/releases/download/v3.5.4/etcd-v3.5.4-linux-amd64.tar.gz && \
      tar -xvf etcd-v3.5.4-linux-amd64.tar.gz && \
      mv etcd-v3.5.4-linux-amd64/etcdctl /usr/local/bin/ && \
      mv etcd-v3.5.4-linux-amd64/etcdutl /usr/local/bin/
    }
}

function main() {
  init
  package_install
  setup_cmd_tools
  setup_dotfiles
  
  if [[ $(hostname) =~ master ]]; then
    install_k8s_tools
  fi
}

date; time main
