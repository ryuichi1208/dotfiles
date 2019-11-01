## Download vim

``` bash
$ git clone https://github.com/vim/vim.git
```

## Install req packages

``` bash
$ yum install -y \
  epel-release \
  lua-devel.x86_64 \
  python-dev python3-dev \
  ruby ruby-devel \
  gcc make ncurses-devel \
  perl-devel perl-ExtUtils-Embed \
  heckinstall mercurial \
   libx11-dev libxt-dev libgtk2.0-dev libncurses5
```

## build

``` bash
$ ./configure \
      --enable-fail-if-missing \
      --with-features=huge \
      --disable-selinux \
      --enable-luainterp \
      --enable-perlinterp \
      --enable-pythoninterp=dynamic \
      --with-python-config-dir=/usr/lib64/python2.7/config \
      --enable-python3interp=dynamic \
      --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu \
      --enable-rubyinterp=dynamic \
      --enable-cscope \
      --enable-fontset \
      --enable-multibyte \
      vi_cv_path_python3=/usr/bin/python3.6

# make && make install
```
