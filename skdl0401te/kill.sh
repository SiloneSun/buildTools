#!/bin/bash

# 定义 kill_proc 函数
kill_proc() {
    # 传递进程名称作为函数参数
    killname=$1
    # 使用 pgrep 命令查找匹配进程并存储进程 ID
    killid=$(pgrep $killname)
    # 如果找到了进程 ID，则使用 kill 命令终止进程
    if [[ -n $killid ]]; then
        echo "Killing process $killname (PID: $killid)..."
        kill -9 $killid
    else
        echo "No process found with name: $killname"
    fi
}

# 终止三个进程
kill_proc prog_usbcam
kill_proc prog_api_server
kill_proc prog_discovery_server
