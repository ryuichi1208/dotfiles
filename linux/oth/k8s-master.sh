#!/bin/bash
# curl -s https://raw.githubusercontent.com/ryuichi1208/dotfiles/master/linux/oth/k8s-master.sh | bash

readonly K8S_VERSION="1.23.6-00"
readonly POD_CIDR="10.244.0.0/16"

function init() {
  modprobe overlay
  modprobe br_netfilter

  cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
  sudo sysctl --system

  apt-get update
  apt-get install -y apt-transport-https ca-certificates curl
  sudo swapoff -a
}

function install_dockerd() {
  apt-get install -y docker.io
}

function install_containerd() {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
  apt-get update && apt-get install -y containerd.io
  mkdir -p /etc/containerd
  containerd config default | sudo tee /etc/containerd/config.toml
  systemctl restart containerd
}

function install_k8s() {
  curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  apt-get update
  apt-get install -y kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION} && apt-mark hold kubelet kubeadm kubectl
}

function setup_master() {
  kubeadm init --pod-network-cidr=${POD_CIDR}
  mkdir -p $HOME/.kube
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
}

function main() {
  init
  install_dockerd
  install_k8s

  if [[ $(hostname) =~ "master" ]]; then
    setup_master
  else
    setup_worker
  fi
}

main
