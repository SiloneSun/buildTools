# cp /mnt/skdl0401te/app/prog_api_server /customer/
# cp /mnt/skdl0401te/app/prog_discovery_server /customer/
# cp /mnt/skdl0401te/app/www.tar.bz2 /customer/
# cp /mnt/skdl0401te/app/prog_usbcam /customer/
# cp /mnt/skdl0401te/app/prog_kmsg_logger /customer/
# cp /mnt/skdl0401te/app/prog_device /customer/
# cp /mnt/skdl0401te/app/prog_msg_forwarder /customer/


SHARE_PATH=/customer/

# 定义 copy_file 函数
copy_file() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    if [ -f "$SHARE_PATH/$file_name" ]; then
        local src_md5=$(md5sum "$file_path" | awk '{print $1}')
        local dst_md5=$(md5sum "$SHARE_PATH/$file_name" | awk '{print $1}')
        if [ "$src_md5" = "$dst_md5" ]; then
            echo -e "skip \033[0;34m$file_name\033[0m"
            return
        fi
    fi
    cp "$file_path" "$SHARE_PATH"
    echo -e "copied [ \033[0;31m$file_name\033[0m] to $SHARE_PATH"
}


copy_file /mnt/skdl0401te/app/www.tar.bz2 
copy_file /mnt/skdl0401te/app/prog_api_server 
copy_file /mnt/skdl0401te/app/prog_discovery_server
copy_file /mnt/skdl0401te/app/prog_usbcam
copy_file /mnt/skdl0401te/app/prog_kmsg_logger
copy_file /mnt/skdl0401te/app/prog_device
copy_file /mnt/skdl0401te/app/prog_msg_forwarder

sync
