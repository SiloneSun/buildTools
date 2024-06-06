#!/bin/bash

# 执行编译
sh make_usbcam.sh

SHARE_PATH=~/work/share/skdl0401te/app/


# 定义 copy_file 函数
copy_file() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    if [ -f "$SHARE_PATH/$file_name" ]; then
        local src_md5=$(md5sum "$file_path" | awk '{print $1}')
        local dst_md5=$(md5sum "$SHARE_PATH/$file_name" | awk '{print $1}')
        if [ "$src_md5" = "$dst_md5" ]; then
            echo "skip copy $file_name"
            return
        fi
    fi
    cp "$file_path" "$SHARE_PATH"
    echo "copied $file_name to $SHARE_PATH"
}

copy_file ./source/i6f/usbcam/www.tar.bz2 
copy_file ./out/arm/app/prog_api_server 
copy_file ./out/arm/app/prog_discovery_server
copy_file ./out/arm/app/prog_usbcam
