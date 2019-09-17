# -----------------------------
# Util
# -----------------------------
function buu()
{
  brew update && brew upgrade
  pip3 list | awk '{print $1}' | xargs -L 1 pip3 install -U
}

function gaa()
{
  MSG=$1

  if [ -z ${MSG} ]; then
    echo "please commit message input!!"
    exit 1
  fi

  git add .
  git commit -m ${MSG}
  git push
}

function gp()
{
  FLG=0
  func=$1
  PACKAGE=$2
  PACKAGE2=$3

  while getopts f: OPT
  do
    case $OPT in
      -f) FILE=${OPTARG}
        FLG=1
        ;;
    esac
  done

  if [ ${FLG} -eq 0 ];then
    grep -IR "sub ${func} {" ./* | grep "${PACKAGE}" | grep "${PACKAGE2}"
  else
    grep -IR "sub ${func} {" ${FILE}
  fi
}

function t()
{
  tmux new-session -s $(pwd |sed -E 's!^.+/([^/]+/[^/]+)$!\1!g' | sed -e 's/\./-/g')
}

function show_uptime ()
{
  uptime | awk '{ print "Uptime:", $3, $4, $5 }' | sed 's/,//g'
  return;
}

function cdl()
{
  builtin cd "$@" && ls -AGF;
}

function psgrep() {
  ps aux | grep -v grep | grep "USER.*COMMAND"
  ps aux | grep -v grep | grep $1
}


# -----------------------------
# Docker/Kubernetes
# -----------------------------
function dstop()
{
  docker stop $(docker ps -a -q);
}

function drm()
{
  docker rm $(docker ps -a -q);
}

function docker-rmi()
{
  docker images \
    | fzf-tmux --reverse --header-lines=1 --multi --ansi \
    | awk '{print $3}' \
    | xargs docker rmi ${1+"$@"}
}

function dtcpdump()
{
  if [ $# -ne 2 ]; then
    echo "Usage: dtcpdump [containe ID|container NAME] PORTNUM"
    exit(1)
  fi

  local _cid=$1
  local _port=$2

  echo 'FROM alpine\nRUN apk add --no-cache tcpdump' \
    | docker build -t debug -f - . \
    && docker run -it --rm --net container:${_cid} debug tcpdump -nn -X port ${_port}
}

function dstrace()
{
  if [ $# -ne 2 ]; then
    echo "Usage: dstrace [containe ID|container NAME] PID"
    exit(1)
  fi

  local _cid=$1
  local _pid=$2

  echo 'FROM alpine\nRUN apk add --no-cache strace' \
    | docker build -t debug -f - . \
    && docker run -it --rm --pid container:${_cid} --cap-add sys_ptrace debug strace -fp ${_pid}
}

# -----------------------------
# Python
# -----------------------------
function pipfreeze()
{
  pip3 freeze -l > ./requirements.txt
}

# -----------------------------
# Git
# -----------------------------
function gt()
{
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

function gr()
{
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

function gs()
{
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# -----------------------------
# fzf
# -----------------------------
# fbr - checkout git branch
function fbr()
{
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fshow - git commit browser
function fshow()
{
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fd - cd to selected directory
function fd()
{
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
