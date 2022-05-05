#!/bin/bash
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/oth/k8s-master.sh | bash

apt update
apt install -y docker.io
systemctl start docker && systemctl enable docker
apt install -y apt-transport-https curl
