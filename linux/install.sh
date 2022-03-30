#!/bin/bash
# usage:
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

VERSION_STRACE=5.16
VERSION_ZSH=5.8.1
VERSION_GO=1.18
VERSION_VIM=8.2.4631

function init() {
  mkdir -p ~/src ~/work ~/tmp ~/.vim/UltiSnips/

  systemctl stop firewalld.service
  systemctl restart chronyd.service
  setenforce 0
  timedatectl set-timezone Asia/Tokyo
}

function yum_install() {
  yum update -y
  yum install -y \
    GeoIP-devel \
    autoconf \
    automake \
    bind-utils \
    cmake \
    crash \
    ctags \
    dstat \
    epel-release \
    gcc \
    gcc-c++ \
    gd-devel \
    gdb \
    git \
    gperftools-devel \
    iperf3 \
    kernel-devel \
    libatomic_ops-devel \
    libevent-devel \
    libxml2-devel \
    libxslt-devel \
    lua-devel \
    make \
    ncurses-devel \
    net-tools \
    openssl-devel \
    patch \
    pcre-devel \
    perf \
    perl-ExtUtils-Embed \
    perl-core \
    perl-devel \
    perl-local-lib \
    python3-devel \
    ruby-devel \
    tcpdump \
    telnet \
    tree \
    unzip \
    wget \
    yum-utils \
    zlib-devel

  yum install -y --enablerepo=epel \
    jq \
    cargo \
    sipcalc \
    htop \
    ShellCheck

  yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  yum -y install ripgrep
  yum -y install https://github.com/muesli/duf/releases/download/v0.8.1/duf_0.8.1_linux_amd64.rpm
  yum -y install https://github.com/dalance/procs/releases/download/v0.12.1/procs-0.12.1-1.x86_64.rpm
  yum -y install https://www.percona.com/downloads/percona-toolkit/3.3.1/binary/redhat/7/x86_64/percona-toolkit-3.3.1-1.el7.x86_64.rpm
  curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
  yum install -y nodejs
}

function install_ext_command() {
  if [[ ! $(type strace) ]]; then
    cd ~/src
    wget https://github.com/strace/strace/releases/download/v${VERSION_STRACE}/strace-${VERSION_STRACE}.tar.xz
    tar -xvf strace-${VERSION_STRACE}.tar.xz
    cd strace-${VERSION_STRACE}
    ./configure && make && make install
  fi

  if [[ ! $(type zsh) ]]; then
    cd ~/src
    wget https://github.com/zsh-users/zsh/archive/refs/tags/zsh-${VERSION_ZSH}.tar.gz
    tar -xvf zsh-${VERSION_ZSH}.tar.gz
    cd zsh-zsh-${VERSION_ZSH}
    ./Util/preconfig && ./configure --enable-multibyte && make && make install
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    chsh -s /usr/local/bin/zsh
  fi

  if [[ ! -d ~/dotfiles ]]; then
    cd ~
    git clone https://github.com/ryuichi1208/dotfiles.git
    ln -s ~/dotfiles/linux/zshrc ~/.zshrc
    ln -s ~/dotfiles/linux/vimrc ~/.vimrc
    ln -s ~/dotfiles/linux/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/linux/.vim/go.snippets ~/.vim/UltiSnips/
  fi

  if [[ ! $(type vim) ]]; then
    cd ~/src
    wget https://github.com/vim/vim/archive/refs/tags/v${VERSION_VIM}.tar.gz
    tar -xvf v${VERSION_VIM}.tar.gz
    cd vim-${VERSION_VIM}
    ./configure \
  --enable-multibyte \
  --enable-nls \
  --enable-python3interp \
  --enable-rubyinterp \
  --enable-luainterp \
  --enable-cscope \
  --enable-fail-if-missing=yes \
  --with-features=huge \
  --without-x \
  --disable-xim \
  --disable-gui \
  --disable-xsmp && make && make install
  fi

  if [[ ! $(which go) ]]; then
    cd ~/src
    wget https://go.dev/dl/go${VERSION_GO}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xvzf go${VERSION_GO}.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin/
    go install golang.org/x/tools/cmd/...@latest
    go install golang.org/x/tools/gopls@latest
    go install golang.org/x/lint/golint@latest
    go install github.com/x-motemen/gore/cmd/gore@latest
    go install github.com/golang/mock/gomock@latest
    go install github.com/golang/mock/mockgen@latest
    go install github.com/mdempsky/gocode@latest
    go install github.com/k0kubun/pp@latest
  fi

  if [[ ! -d ~/.cache/dein ]]; then
    mkdir -p ~/.cache/dein
    cd ~/.cache/dein
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein
  fi

  if [[ ! -d ~/z ]]; then
    git clone https://github.com/rupa/z.git ~/z
  fi

  if [[ ! -d ~/.fzf ]]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
  fi

  if [[ ! $(type bat) ]]; then
    cd ~/src
    wget -O bat.zip https://github.com/sharkdp/bat/releases/download/v0.20.0/bat-v0.20.0-x86_64-unknown-linux-musl.tar.gz
    tar -xvf bat.zip
    mv bat-v0.20.0-x86_64-unknown-linux-musl/bat /usr/local/bin/
  fi

  if [[ ! $(type tmux) ]]; then
    cd ~/src
    wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz
    tar -xvf tmux-3.2a.tar.gz
    ./configure && make && make install
  fi
}

function main() {
  init
  yum_install
  install_ext_command
}

time main
