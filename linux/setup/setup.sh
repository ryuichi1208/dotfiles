#!/bin/bash

yum update -y
yum install -y \
    automake \
    bzip2 \
    ctags \
    curl \
    dstat \
    gcc \
    git \
    htop \
    make \
    net-tools \
    openssl-devel \
    pcre-devel \
    readline-devel \
    strace \
    telnet \
    vim \
    wget \
    xz-devel \
    zlib-devel \
    zsh

chsh -s $(which zsh)
curl -so ~/.vimrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/vimrc
curl -so ~/.zshrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/zshrc

#### fzf ####
wget https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz
tar -xvf fzf-0.27.2-linux_amd64.tar.gz && mv fzf /usr/local/bin/

#### ag ####
wget https://github.com/ggreer/the_silver_searcher/archive/refs/tags/2.2.0.tar.gz
tar -xvf 2.2.0.tar.gz && ./the_silver_searcher-2.2.0/build.sh && mv the_silver_searcher-2.2.0/ag /usr/local/bin

#### nodejs ####
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
yum install -y nodejs

#### rbenv ####
zsh
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

systemctl stop firewalld
setenforce 0
