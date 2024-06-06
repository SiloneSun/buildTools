#!/bin/bash

# 初始化变量
prev_rx_bytes=0
curr_rx_bytes=0
bytes_per_sec=0

first_run=true

while true; do
    # 获取当前秒的接收字节数
    curr_rx_bytes=$(cat /proc/net/dev | grep eth0 | tr -s ' ' | cut -d' ' -f3)

    if [ $first_run = false ]; then
        # 获取当前系统时间
        current_time=$(date +"%Y-%m-%d %H:%M:%S")

        # 计算每秒字节数（单位：KB）
        bytes_per_sec=$(( (curr_rx_bytes - prev_rx_bytes) / 1024 ))

        # 打印每秒字节数和系统时间
        echo "$current_time - eth0: $bytes_per_sec KB/s"
    fi

    # 更新prev_rx_bytes为当前秒的接收字节数
    prev_rx_bytes=$curr_rx_bytes

    # 更新first_run标志
    first_run=false

    # 等待一秒
    sleep 1
done
