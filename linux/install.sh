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
  git \
  ncurses-devel \
  make \
  cmake \
  pcre-devel \
  zlib-devel \
  openssl-devel \
  wget

cd ~/src

if [[ ! $(which strace) ]]; then
  wget https://github.com/strace/strace/releases/download/v5.16/strace-5.16.tar.xz
  tar -xvf strace-5.16.tar.xz
  cd strace-5.16
  ./configure && make && make install
  cd ..
fi
