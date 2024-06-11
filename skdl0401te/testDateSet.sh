#!/bin/bash

# 获取当前系统时间的时间戳
current_timestamp=$(date +%s)
echo "当前系统时间: $(date -d @$current_timestamp)"

# 主循环，每次延后一天
while true; do
    # 计算下一天的时间戳
    next_day_timestamp=$((current_timestamp + 86400))  # 86400 秒 = 1 天

    # 将时间戳转换为日期时间格式
    next_day=$(date -d @$next_day_timestamp +"%Y-%m-%d %H:%M:%S")

    # 设置系统时间
    date -s "$next_day"

    # 显示设置后的时间
    updated_time=$(date)
    echo "已设置系统时间为: $updated_time"

    # 更新当前时间戳
    current_timestamp=$next_day_timestamp

    # 等待10秒
    sleep 10
done
