echo dump_out 0 15000 /mnt > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 1 15000 /mnt > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 0 15000 /mnt > /proc/mi_modules/mi_venc/mi_venc1
echo dump_out 1 15000 /mnt > /proc/mi_modules/mi_venc/mi_venc1

cat /proc/mi_modules/mi_venc/mi_venc0 > /userdata/sxl/venc0_info.txt
cat /proc/mi_modules/mi_venc/mi_venc1 > /userdata/sxl/venc1_info.txt

