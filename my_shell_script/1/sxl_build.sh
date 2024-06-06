#!/bin/bash
sh build_sv_sdk.sh
SHARE_PATH=~/work/share/skdl0401p/lib

# 定义 copy_file 函数
copy_file() {
    local file_path="$1"
    #打印file_path的md5值
    md5sum "$file_path"
    local file_name=$(basename "$file_path")
    if [ -f "$SHARE_PATH/$file_name" ]; then
        local src_md5=$(md5sum "$file_path" | awk '{print $1}')
        local dst_md5=$(md5sum "$SHARE_PATH/$file_name" | awk '{print $1}')
        if [ "$src_md5" = "$dst_md5" ]; then
            echo "~~~~~~~~skip $file_name"
            return
        fi
    fi
    cp "$file_path" "$SHARE_PATH"
    echo "!!!!!!!!copied $file_name to $SHARE_PATH"
}

copy_file ./out/sv/sdk/media_sdk/lib/libmedia_interface.so
copy_file ./out/sv/sdk/media_sdk/lib/libutils.so
copy_file ./out/sv/sdk/media_sdk/lib/libmi_internal.so

copy_file ./out/sv/sdk/device_sdk/lib/libdevice_sdk.so
copy_file ./out/sv/sdk/device_sdk/lib/libjsoncpp.so

cp -r ./out/sv/sdk/ ../../../sv22apis

