#!/bin/bash

repo_list=$(find . -type d -maxdepth 1 | grep -v "\.$")
dir=$(pwd)
ret=0

for repo in ${repo_list[@]}; do
  cd $repo && res=$(git status)

  if [ "$(echo $res | grep -e 'Untracked files' -e 'Changes not staged for commit')" ]; then
    echo "$repo is a difference"
    ret=1
  fi
  cd $dir
done

exit ${ret}
