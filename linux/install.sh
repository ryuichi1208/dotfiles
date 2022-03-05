#!/bin/bash
# usage:
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

mkdir -p ~/src

systemctl stop firewalld
setenforce 0

yum update -y
yum install -y \
  gcc \
  gcc-c++ \
  gdb \
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
  autoconf

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
fi
