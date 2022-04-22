#!/bin/bash

function apt_update() {
  apt update && apt upgrade
}

function package_install() {
  apt install -y \
    apache2-utils \
    autoconf \
    automake \
    bat \
    build-essential \
    cproto \
    dstat \
    duf \
    exa \
    exuberant-ctags \
    fzf \
    gettext \
    golang \
    hexyl \
    iperf3 \
    libacl1-dev \
    libgpm-dev \
    libgtk-3-dev \
    liblua5.2-dev \
    libluajit-5.1-dev \
    libncurses-dev \
    libpcre3-dev \
    libtinfo-dev \
    libxmu-dev \
    libxpm-dev \
    linux-tools-common \
    lua5.2 \
    luajit \
    net-tools \
    nodejs \
    peco \
    python3-dev \
    ruby-dev \
    shellcheck \
    zlib1g-dev \
    zsh
}

function main() {
  apt_update
  package_install
}

main
