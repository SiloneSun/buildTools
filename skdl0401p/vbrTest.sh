#!/bin/bash

# 文件路径
DATA_FILE="/userdata/sxl/vbr_bitrate.txt"
DATA_FILE2="/userdata/sxl/vbr_prof_info_venc.txt"

# PYTHON_SCRIPT="plot_data.py"

# 清空数据文件
echo "ChnId  State  EnPred  base  enhance MaxStreamCnt  Fps_1s    kbps1s  Fps10s    kbps10s" > "$DATA_FILE"
echo "cat /proc/mi_modules/mi_venc/mi_venc1 :" > "$DATA_FILE2"

total_bit=0
total_count=0
peak_max_bitrate=0
peak_min_bitrate=9999999
target_bitrate=0
# 定义函数来读取和保存数据
record_data() {
    cat /proc/mi_modules/mi_venc/mi_venc1 | grep -E "^[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+([0-9]+)[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+[0-9]+$" >> "$DATA_FILE"

    cat /proc/mi_modules/mi_venc/mi_venc1 >> "$DATA_FILE2"
    if [ $target_bitrate -eq 0 ]; then
        file="/proc/mi_modules/mi_venc/mi_venc1"
        content="ChnId RateCtl  GOP MaxBitrate  IPQPDelta  MaxQp  MinQp  MaxIQp  MinIQp  MaxISize  MaxPSize MaxIPProp  ChangePos  QpMap  AbsQp  ModeMap"
        matching_lines=$(grep -A 1 "$content" "$file" | tail -n 1)
        target_bitrate=$(echo "$matching_lines" | awk '{print $4}')
        target_bitrate=$(( target_bitrate / 1024 ))
        echo "target_bitrate $target_bitrate"
    fi
    local bitrate
    content2="ChnId  State  EnPred  base  enhance MaxStreamCnt  Fps_1s    kbps1s  Fps10s    kbps10s"
    matching_lines2=$(grep -A 1 "$content2" "$file" | tail -n 1)
    bitrate=$(echo "$matching_lines2" | awk '{print $8}')

    # bitrate=$(cat /proc/mi_modules/mi_venc/mi_venc1 | grep -E "^[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+([0-9]+)[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+[0-9]+$"|awk '{print $8}')
    
    total_bit=$(( total_bit + bitrate ))
    total_count=$(( total_count + 1 ))  
    average_bitrate=$(( total_bit / total_count ))
    if [ $bitrate -lt $peak_min_bitrate ]; then
        peak_min_bitrate=$bitrate
    fi
    if [ $bitrate -gt $peak_max_bitrate ]; then
        peak_max_bitrate=$bitrate
    fi
    up_peak_rate=$(awk "BEGIN {printf \"%.2f\", (($peak_max_bitrate - $target_bitrate) / $target_bitrate * 100)}")
    down_peak_rate=$(awk "BEGIN {printf \"%.2f\", (($average_bitrate - $target_bitrate) / $target_bitrate * 100)}")
    br_range_rate=$(awk "BEGIN {printf \"%.2f\", (($bitrate - $target_bitrate) / $target_bitrate * 100)}")
    echo "avg_br:$average_bitrate, br:$bitrate ( $br_range_rate % ), max:$peak_max_bitrate ( $up_peak_rate % ), min:$peak_min_bitrate ( $down_peak_rate % ), total: $total_bit"
    echo "avg_br:$average_bitrate, br:$bitrate ( $br_range_rate % ), max:$peak_max_bitrate ( $up_peak_rate % ), min:$peak_min_bitrate ( $down_peak_rate % ), total: $total_bit" >> "$DATA_FILE2"
}

# 每隔一秒记录一次数据
i=0
echo dump_out 0 7500 /storage > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 1 7500 /storage > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 0 7500 /storage > /proc/mi_modules/mi_venc/mi_venc1
echo dump_out 1 7500 /storage > /proc/mi_modules/mi_venc/mi_venc1
while [ $i -lt 300 ]; do
    record_data
    sleep 1
    i=$((i+1))
done