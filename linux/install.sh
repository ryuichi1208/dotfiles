#!/bin/bash
# usage:
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

mkdir -p ~/src

systemctl stop firewalld
setenforce 0

yum update -y
yum install -y \
  yum-utils \
  kernel-devel \
  gcc \
  gcc-c++ \
  gdb \
  gdb-debuginfo \
  git \
  ncurses-devel \
  make \
  cmake \
  pcre-devel \
  zlib-devel \
  openssl-devel \
  wget \
  dstat \
  perf \
  autoconf \
  python3-devel \
  perl-devel \
  perl-ExtUtils-Embed \
  perl-core \
  perl-local-lib \
  ruby-devel \
  lua-devel

yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
yum -y install ripgrep

cd ~/src

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

if [[ ! -e "~/dotfiles" ]]; then
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

if [[ ! (which go) ]]; then
  cd ~/src
  wget https://go.dev/dl/go1.17.8.linux-amd64.tar.gz
  tar -xvf go1.17.8.linux-amd64.tar.gz
  mv go/bin /usr/local/go
fi
