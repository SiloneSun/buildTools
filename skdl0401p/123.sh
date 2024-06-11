#!/bin/bash

start_time=$(date +%s)
total_bitrate=0
total_frames=0

while true; do
    result=$(cat /proc/mi_modules/mi_venc/mi_venc1)
    bitrate=$(echo "$result" | awk '/^ChnId.*kbps1s/ {print $8}')
    timestamp=$(date +%s)

    if [ -n "$bitrate" ]; then
        echo "Current Bitrate: $bitrate kbps"

        total_bitrate=$((total_bitrate + bitrate))
        total_frames=$((total_frames + 1))

        average_bitrate=$((total_bitrate / total_frames))
        elapsed_time=$((timestamp - start_time))

        echo "Average Bitrate: $average_bitrate kbps"
        echo "Elapsed Time: $elapsed_time seconds"
    fi

    sleep 1
done
