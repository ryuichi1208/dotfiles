#!/bin/bash

yum update -y
yum install -y \
    curl \
    gcc \
    git \
    vim \
    zsh

chsh -s $(which zsh)
curl -so ~/.vimrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/vimrc
curl -so ~/.zshrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/zshrc
