i=0

dump_cnt=45000

# SAVE_PATH="/storage"
SAVE_PATH="/mnt"


mkdir -p $SAVE_PATH/dump/

cat /proc/mi_modules/mi_venc/mi_venc0 > $SAVE_PATH/dump/proc_info.txt
cat /proc/mi_modules/mi_venc/mi_venc1 >> $SAVE_PATH/dump/proc_info.txt

while true
do

DIR="$SAVE_PATH/dump/$(date "+%Y.%m.%d-%H:%M:%S")"
mkdir -p $DIR

echo dump_out 0 $dump_cnt $DIR > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 1 $dump_cnt $DIR > /proc/mi_modules/mi_venc/mi_venc0
echo dump_out 0 $dump_cnt $DIR > /proc/mi_modules/mi_venc/mi_venc1
echo dump_out 1 $dump_cnt $DIR > /proc/mi_modules/mi_venc/mi_venc1

sleep $(($dump_cnt / 25 + 1))
echo ----------------------

done
