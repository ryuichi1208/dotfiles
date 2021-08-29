#!/bin/bash

yum update -y
yum install -y \
    gcc \
    vim \
    curl \
    zsh

curl -so ~/.vimrc https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/vimrc
