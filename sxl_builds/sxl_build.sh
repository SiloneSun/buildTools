#!/bin/bash
./build_sv_sdk.sh
SHARE_PATH=~/work/share/skdl0401p/lib
# 定义 copy_file 函数
copy_file() {
    local file_path="$1"
    #打印file_path的md5值
    local src_md5=$(md5sum "$file_path" | awk '{print $1}')
    local file_name=$(basename "$file_path")
    if [ -f "$SHARE_PATH/$file_name" ]; then
        local dst_md5=$(md5sum "$SHARE_PATH/$file_name" | awk '{print $1}')
        if [ "$src_md5" = "$dst_md5" ]; then
            echo -e "[ \033[0;34m$src_md5\033[0m ] [ \033[0;34m$file_name\033[0m ] skip"
            return
        fi
    fi
    cp "$file_path" "$SHARE_PATH"
    echo -e "[ \033[0;31m$src_md5\033[0m ] [ \033[0;31m$file_name\033[0m ] copied to [ \033[0;31m$SHARE_PATH\033[0m ]"
}

copy_file ./out/sv/sdk/media_sdk/lib/libmedia_interface.so
copy_file ./out/sv/sdk/media_sdk/lib/libutils.so
copy_file ./out/sv/sdk/media_sdk/lib/libmi_internal.so

copy_file ./out/sv/sdk/device_sdk/lib/libdevice_sdk.so
copy_file ./out/sv/sdk/device_sdk/lib/libjsoncpp.so

cp -r ./out/sv/sdk/* ../../../sv22apis



# if [ -f ./make_kmsg.sh ]; then
# 	./make_kmsg.sh
# 	ls -trl ./out/arm64/app/prog_kmsg_logger
# 	md5sum ./out/arm64/app/prog_kmsg_logger
# 	cp ./out/arm64/app/prog_kmsg_logger ~/work/share/skdl0401p/lib/
# fi



# cp -r ./out/sv/sdk/ ./kdl0401p_at_test
# cd kdl0401p_at_test
# export CROSS_COMPILE=/home/sxl/code/skdl0401p/tools/gcc-10.2.1-20210303-sigmastar-glibc-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
# make clean
# make
# copy_file at_test 
