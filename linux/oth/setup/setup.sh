#!/bin/bash

yum update -y
yum install -y \
    automake \
    bind-utils \
    bzip2 \
    ctags \
    curl \
    dstat \
    epel-release \
    gcc \
    git \
    htop \
    iftop \
    kernel-devel \
    lua-devel \
    make \
    net-tools \
    openssl-devel \
    pcre-devel \
    readline-devel \
    strace \
    tcpdump \
    telnet \
    vim \
    wget \
    xz-devel \
    yum-utils \
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
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
.rbenv/bin/rbenv install 2.6.8
.rbenv/bin/rbenv global 2.6.8
.rbenv/bin/rbenv rehash

#### lltsv ####
wget https://github.com/sonots/lltsv/releases/download/v0.7.0/lltsv_linux_amd64 -O lltsv
chmod +x lltsv
mv lltsv /usr/local/bin

#### firewalld ####
systemctl stop firewalld
systemctl disable firewalld

#### selinux ####
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

#### swap ####
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab

#### containerd ####
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

yum install -y device-mapper-persistent-data lvm2
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum update -y && yum install -y containerd.io
mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
systemctl restart containerd
