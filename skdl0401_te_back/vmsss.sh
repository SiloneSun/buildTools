#!/bin/sh
if [ -n "$1" ]; then
    pid=$1
    echo "The $1 is $1, $pid liulixiang"
    echo $pid
else
    echo "Please provide a PID as argument."
    exit 1
fi

interval=5

while true; do
    DATE=$(date '+%Y-%m-%d-%H:%M:%S')
    current_VmRSS=$(cat /proc/$pid/status | grep -e VmRSS)
    current_VmSize=$(cat /proc/$pid/status | grep -e VmSize)
    echo "time: $DATE ;  $current_VmRSS;   $current_VmSize"
    sleep $interval
done
