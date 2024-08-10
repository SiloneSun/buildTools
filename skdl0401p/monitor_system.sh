#!/bin/bash
record_dir="/userdata"
record_file="$record_dir/cpu_mem_info/cpu_mem_info_$(date +%Y%m%d_%H%M%S).txt"
mkdir -p "$record_dir/cpu_mem_info"
echo "" > "$record_file"
echo 0 > "$record_dir/monitor_flag"
while true; do
    running_flag=$(cat "$record_dir/monitor_flag")
    echo "monitor_flag = $running_flag"
    if [ $running_flag -eq 0 ]; then
        sleep 1
    else
        current_time=$(date "+%Y-%m-%d %H:%M:%S")
        top_info=$(top -bn1)
        echo "[$current_time]" >> "$record_file"
        echo "$top_info" >> "$record_file"
        sleep 1
    fi
done