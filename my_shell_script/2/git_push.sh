#!/bin/bash

if [ $# -eq 0 ]; then
  # 如果没有参数
  git commit --amend --no-edit
else
  # 如果有参数
  git commit -m "[系统软件][系统][skdl0401_te]$*"
fi

git push origin HEAD:refs/for/skdl0401_te
