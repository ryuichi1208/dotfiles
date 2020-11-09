#!/bin/bash

set(MAC_CODESIGN_ID "" CACHE STRING "Mac code-signing identity")
set(MAC_INJECT_GET_TASK_ALLOW ON CACHE BOOL "Inject get-task-allow on Mac")

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip"
unzip /tmp/awscli-bundle.zip -d /tmp
/tmp/awscli-bundle/install -b $DOTFILES/bin/aws
rm -rf /tmp/awscli-bundle*
