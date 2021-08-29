#!/bin/bash

yum update -y
yum install -y \
    automake \
    ctags \
    curl \ 
    gcc \
    git \
    make \
    pcre-devel \
    vim \
    wget 
    xz-devel \ 
    zlib-devel \
    zsh

chsh -s $(which zsh)
curl -so ~/.vimrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/vimrc
curl -so ~/.zshrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/zshrc

wget https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz
tar -xvf fzf-0.27.2-linux_amd64.tar.gz && mv fzf /usr/local/bin/
wget https://github.com/ggreer/the_silver_searcher/archive/refs/tags/2.2.0.tar.gz
tar -xvf 2.2.0.tar.gz && ./the_silver_searcher-2.2.0/build.sh && mv mv the_silver_searcher-2.2.0/ag /usr/local/bin
