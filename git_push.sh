#!/bin/bash

# 获取当前分支的上游分支
upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})

# 检查命令是否成功
if [ $? -ne 0 ]; then
  echo "无法获取上游分支信息"
  exit 1
fi

# 提取远程名称和分支名称
remote=$(echo "$upstream" | cut -d'/' -f1)
branch=$(echo "$upstream" | cut -d'/' -f2-)

# 输出结果
echo "远程名称: $remote"
echo "分支名称: $branch"

# 根据参数决定提交操作
if [ $# -eq 0 ]; then
  # 如果没有参数
  git commit --amend --no-edit
else
  # 如果有参数
  git commit -m "[系统软件][系统][$branch]$*"
fi

# 使用提取的远程名称进行推送
git push $remote HEAD:refs/for/$branch
# git push -u $remote $branch
