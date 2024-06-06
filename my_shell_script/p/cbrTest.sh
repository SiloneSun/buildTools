#!/bin/bash

# 文件路径
DATA_FILE="/userdata/sxl/venc_data.txt"
# PYTHON_SCRIPT="plot_data.py"

# 清空数据文件
echo "ChnId  State  EnPred  base  enhance MaxStreamCnt  Fps_1s    kbps1s  Fps10s    kbps10s" > "$DATA_FILE"

# 定义函数来读取和保存数据
record_data() {
    cat /proc/mi_modules/mi_venc/mi_venc0 | grep -E "^[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+([0-9]+)[[:space:]]+[0-9]+\.[0-9]+[[:space:]]+[0-9]+$" >> "$DATA_FILE"
}

# 每隔一秒记录一次数据，共记录120次
i=0
while [ $i -lt 120 ]; do
    record_data
    sleep 1
    i=$((i+1))
done