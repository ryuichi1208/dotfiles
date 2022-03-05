#!/bin/bash
# usage:
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/install.sh | bash

systemctl stop firewalld
setenforce 0

yum update -y
yum install -y \
  gcc \
  gcc-c++ \
  git \
  ncurses-devel \
  make \
  pcre-devel \
  zlib-devel \
  openssl-devel
