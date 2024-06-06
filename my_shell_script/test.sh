#!/bin/bash

# 获取基准值
base_mem=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
echo "BasicMem: $base_mem kB"

# 记录脚本开始时间
start_time=$(date +%s)

format_time() {
    local total_seconds=$1
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    printf "%02d:%02d:%02d" $hours $minutes $seconds
}

# 循环执行1000次
count=1
while [ $count -le 1000 ]
do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))
    
    current_mem=$(cat /proc/meminfo | grep MemAvailable | awk '{print $2}')
    diff=$((current_mem - base_mem))
    percentage=$(awk "BEGIN {printf \"%.3f\", ($diff/$base_mem)*100}")
    
    formatted_time=$(format_time $elapsed_time)
    
    echo "[$formatted_time] MemAvailable:     $current_mem kB ($percentage%) | "
    sleep 1
    # count=$((count + 1))
done
