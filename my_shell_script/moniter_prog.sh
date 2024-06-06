#!/bin/bash

# 定义要监控的进程列表
process1="prog_msg_forwarder"
process2="prog_usbcam"
process3="prog_discovery_server"
process4="prog_device"
process5="prog_api_server"
process6="prog_kmsg_logger"

# 定义监控函数
monitor_processes() {
    while true; do
        # 标记是否有进程需要重新启动
        restart_required=false
        
        # 检查第一个进程是否在运行
        if ! pgrep -x "$process1" >/dev/null; then
            echo "$process1 is not running, restarting..."
            restart_required=true
        fi

        # 如果有进程需要重新启动，则杀死它们并重新拉起
        if [ "$restart_required" = true ]; then
            # 先杀死所有进程
            echo "kill 1" # pkill -x "$process1"
            # 然后按照固定的顺序重新启动
            echo "run 1" #/customer/"$process1" &
        fi
        
        # 等待5秒后再次检查
        sleep 5
    done
}

# 调用监控函数
monitor_processes
