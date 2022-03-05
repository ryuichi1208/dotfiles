#!/bin/bash
# usage:
# curl -s https://raw.github.com/ryuichi1208/dotfilese/master/linux/install.sh | bash

systemctl stop firewalld
setenforce 0
