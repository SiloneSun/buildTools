#!/bin/bash

# 文件路径
file="/proc/mi_modules/mi_venc/mi_venc1"

# 指定内容
content="ChnId RateCtl  GOP MaxBitrate  IPQPDelta  MaxQp  MinQp  MaxIQp  MinIQp  MaxISize  MaxPSize MaxIPProp  QpMap  AbsQp  ModeMap"
content2="ChnId  State  EnPred  base  enhance MaxStreamCnt  Fps_1s    kbps1s  Fps10s    kbps10s"

# 使用 grep 命令查找包含指定内容的行以及后续一行
matching_lines=$(grep -A 1 "$content" "$file" | tail -n 1)
matching_lines2=$(grep -A 1 "$content2" "$file" | tail -n 1)

# 输出匹配的行以及后续一行
echo "$matching_lines"