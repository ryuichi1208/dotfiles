#!/bin/bash

yum update -y
yum install -y \
    ctags \
    curl \ 
    gcc \
    git \
    vim \
    zsh

chsh -s $(which zsh)
curl -so ~/.vimrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/vimrc
curl -so ~/.zshrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/zshrc

wget https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz
tar -xvf fzf-0.27.2-linux_amd64.tar.gz && mv fzf /usr/local/bin/
