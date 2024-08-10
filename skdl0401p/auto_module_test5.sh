#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/oem/engine/mpp

counter=0
while true; do
    # 执行命令
    counter=$((counter+1))
    

    /oem/engine/mpp/module_test -5 &
    pid=$!  # 获取进程ID

    # 等待10秒
    sleep 20

    # 发送Ctrl+Z信号（SIGTSTP）到进程
    kill -SIGTSTP $pid

    # 等待10秒
    sleep 15

    # 检查进程是否仍然存在
    if ! ps -p $pid > /dev/null; then
        echo "normol, continue... counter=$counter, pid=$pid"
        rm /tmp/COMPOSITE_STREAM_*
        rm /tmp/STREAM_*
        sleep 2
        continue
    else
        echo "Error!!! Check why program not stop!  counter=$counter, pid=$pid"
        exit 1
    fi
done