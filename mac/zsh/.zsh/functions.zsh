# -----------------------------
# Util
# -----------------------------
function buu()
{
  # brew
  brew update && brew upgrade && brew cleanup

  # zplug
  zplug self-update && zplug update

  # npm
  # npm update -g npm && npm update -g
}

function chpwd()
{
    ls_abbrev
}

function ls_abbrev()
{
  if [[ ! -r $PWD ]]; then
      return
  fi
  # -a : Do not ignore entries starting with ..
  # -C : Force multi-column output.
  # -F : Append indicator (one of */=>@|) to entries.
  local cmd_ls='ls'
  local -a opt_ls
  opt_ls=('-aCF' '--color=always')
  case "${OSTYPE}" in
      freebsd*|darwin*)
          if type gls > /dev/null 2>&1; then
              cmd_ls='gls'
          else
              # -G : Enable colorized output.
              opt_ls=('-aCFG')
          fi
          ;;
  esac

  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

  local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

  if [ $ls_lines -gt 10 ]; then
      echo "$ls_result" | head -n 5
      echo '...'
      echo "$ls_result" | tail -n 5
      echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
  else
      echo "$ls_result"
  fi
}

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
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

function encode()
{
  echo "$1" | nkf -WwMQ | sed 's/=$//g' | tr = % | tr -d '\n'
}

function dcode()
{
  if [ $# -eq 2 ]; then
    echo $2 | nkf -WwMQ | tr = %
  else
    echo $1 | nkf --url-input
  fi
}

function fcurl()
{
  curl -o /dev/null -vsLS -w \
    "
      time_appconnect: %{time_appconnect}\n \
     time_connect: %{time_connect}\n \
     time_namelookup: %{time_namelookup}\n \
     time_pretransfer: %{time_pretransfer}\n \
     time_redirect: %{time_redirect}\n \
     time_starttransfer: %{time_starttransfer}\n \
     time_total: %{time_total}\n
    " \
     ${1}
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

function fbrr()
{
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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

function fkill()
{
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

function fcoc()
{
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}


function gmsg()
{
  BRANCH_LIST=$(git branch -a | sed s/\*//| awk '{print $1}')
  for i in ${BRANCH_LIST[@]}; do
    git checkout ${i} > /dev/null
    git log -1 --oneline
  done
}

function fb()
{
  FZF_DEFAULT_OPTS="--height 40% --reverse --border --preview \
    'bat --color=always --style=header,grid --line-range :100 {}'" \
    fzf | xargs -L1 bat
}

function peco-vim()
{
    local src=$(git ls-files | peco --query "$LBUFFER" --prompt "vim>")
    if [ -n "$src" ]; then
        BUFFER="vim $src"
        zle accept-line
    fi
    zle -R -c
}
