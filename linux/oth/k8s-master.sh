#!/bin/bash
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/oth/k8s-master.sh | bash

swapoff -a
apt update
apt install -y docker.io
systemctl start docker && systemctl enable docker
apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt install -y kubeadm kubelet kubectl kubernetes-cni
