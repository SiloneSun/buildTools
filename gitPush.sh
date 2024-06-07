#!/bin/bash

if [ $# -eq 0 ]; then
  # 如果没有参数
  git commit --amend --no-edit
else
  # 如果有参数
  git commit -m "[AutoUpdate]$*"
fi

git push origin HEAD:refs/for/main
git push -u origin main