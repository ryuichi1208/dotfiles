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
  cd v8.2.4510
fi
