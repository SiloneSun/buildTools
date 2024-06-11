scl_file=/proc/mi_modules/mi_scl/mi_scl1
scl_content_begin="devId  chnId  portId  sclid bindtype  Enable      Pixel  bMirr/flip  Compress           PortCrop  OutputW  OutputH  Histogram  MatchLine  Stride  GetCnt  FailCnt  FinishCnt  fps"
scl_content_end="End dump SCL OUTPUT PORT info"
scl_line_number_begin=$(grep -n "$scl_content_begin" "$scl_file" | awk -F: '{print $1}')
scl_line_number_end=$(grep -n "$scl_content_end" "$scl_file" | awk -F: '{print $1}')

awk "NR>$scl_line_number_begin && NR<$scl_line_number_end" "$scl_file" | while IFS= read -r line; do
    # echo "Processing line: $line"
    devId=$(echo "$line" | awk '{print $1}')
    chnId=$(echo "$line" | awk '{print $2}')
    portId=$(echo "$line" | awk '{print $3}')
    Enable=$(echo "$line" | awk '{print $6}')
    # 如果需要进一步处理这些值，可以在这里添加逻辑
    if [ "$Enable" -eq 1 ]; then
        mkdir -p "/tmp/dumpyuv/scl_${devId}-${chnId}"
        echo "dump yuv scl { $devId , $chnId }"
        echo dumptaskfile ${chnId} 3 /tmp/dumpyuv/scl_${devId}-${chnId} > /proc/mi_modules/mi_scl/mi_scl${devId}
    fi
done


mkdir -p "/tmp/dumpyuv/isp0"
echo dumptaskfile 0 3 /tmp/dumpyuv/isp0 > /proc/mi_modules/mi_isp/mi_isp0

mkdir -p "/tmp/dumpyuv/isp1"
echo dumptaskfile 0 3 /tmp/dumpyuv/isp1 > /proc/mi_modules/mi_isp/mi_isp1

mkdir -p "/tmp/dumpyuv/vif0"
echo dump 0 0 /tmp/dumpyuv/vif0 3 > /proc/mi_modules/mi_vif/mi_vif0

mkdir -p "/tmp/dumpyuv/vif8"
echo dump 8 0 /tmp/dumpyuv/vif8 3 > /proc/mi_modules/mi_vif/mi_vif8

mkdir -p "/tmp/dumpyuv/vif16"
echo dump 16 0 /tmp/dumpyuv/vif16 3 > /proc/mi_modules/mi_vif/mi_vif16

