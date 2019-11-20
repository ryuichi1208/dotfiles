## install

```
$ yum update

$ yum install -y \
  vim \
  curl \
  sysstat \
  gcc \
  wget \
  bash-completion

$ systemctl stop firewalld
$ setenforce 0
```

## prometeus

```
$ mkdir /usr/local/src/prometheus && cd $_
$ wget https://github.com/prometheus/prometheus/releases/download/v2.14.0/prometheus-2.14.0.linux-amd64.tar.gz
$ wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz

$ tar -xvf prometheus-2.14.0.linux-amd64.tar.gz
$ tar -xvf node_exporter-0.18.1.linux-amd64.tar.gz
```
