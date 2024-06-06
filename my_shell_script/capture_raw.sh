echo dump 16 0 /userdata > /proc/mi_modules/mi_vif/mi_vif16
cd /userdata
# 找到 mi_vifDev16 开头的raw文件，记录为raw_file
raw_file=$(find /userdata -name 'mi_vifDev16*')
base_raw=$(basename "$raw_file")
filename="${base_raw}.tar.gz"
tar -zcvf $filename $raw_file
rm $raw_file
cp $filename /mnt
rm $filename