#!/bin/bash
# usage:
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

function init() {
  mkdir -p ~/src

  systemctl stop firewalld
  setenforce 0
  timedatectl set-timezone Asia/Tokyo

  yum update -y
  yum install -y \
    GeoIP-devel \
    autoconf \
    bind-utils \
    cmake \
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
    libxml2-devel \
    libxslt-devel \
    lua-devel \
    make \
    ncurses-devel \
    net-tools \
    openssl-devel \
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

  if [[ ! $(which strace) ]]; then
    cd ~/src
    wget https://github.com/strace/strace/releases/download/v5.16/strace-5.16.tar.xz
    tar -xvf strace-5.16.tar.xz
    cd strace-5.16
    ./configure && make && make install
  fi

  if [[ ! $(which zsh) ]]; then
    cd ~/src
    wget https://github.com/zsh-users/zsh/archive/refs/tags/zsh-5.8.1.tar.gz
    tar -xvf zsh-5.8.1.tar.gz
    cd zsh-zsh-5.8.1
    ./Util/preconfig && ./configure --enable-multibyte && make && make install
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    chsh -s /usr/local/bin/zsh
  fi

  if [[ ! -d ~/dotfiles ]]; then
    cd ~
    git clone https://github.com/ryuichi1208/dotfiles.git
    ln -s ~/dotfiles/linux/zshrc ~/.zshrc
    ln -s ~/dotfiles/linux/vimrc ~/.vimrc
  fi

  if [[ ! $(which vim) ]]; then
    cd ~/src
    wget https://github.com/vim/vim/archive/refs/tags/v8.2.4510.tar.gz
    tar -xvf v8.2.4510.tar.gz
    cd vim-8.2.4510
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
    wget https://go.dev/dl/go1.17.8.linux-amd64.tar.gz
    sudo tar -C /usr/local -xvzf go1.17.8.linux-amd64.tar.gz
  fi

  if [[ ! -d ~/.cache/dein ]]; then
    mkdir -p ~/.cache/dein
    cd ~/.cache/dein
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein
  fi

  if [[ ! $(which bat) ]]; then
    cd ~/src
    wget -O bat.zip https://github.com/sharkdp/bat/releases/download/v0.20.0/bat-v0.20.0-x86_64-unknown-linux-musl.tar.gz
    tar -xvf bat.zip
    mv bat-v0.20.0-x86_64-unknown-linux-musl/bat /usr/local/bin/
  fi

  if [[ ! -d ~/z ]]; then
    git clone https://github.com/rupa/z.git ~/z
  fi

  if [[ ! -d ~/.fzf ]]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
  fi
}

time init
