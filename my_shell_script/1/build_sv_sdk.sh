#!/bin/bash

set -e

declare -x PATH="$PWD/../../../tools/gcc-10.2.1-20210303-sigmastar-glibc-x86_64_aarch64-linux-gnu/bin/:$PATH"
declare -x CROSS_COMPILE=aarch64-linux-gnu-
declare -x ARCH=arm64

echo "==============================================="
echo "             Building SV SDK"
echo "==============================================="

rm -rf out/sv/

CHANGE_ID=$(git log -1 --pretty=format:%h)
sed -i "s/static std::string versionCode = \".*\";/static std::string versionCode = \"$CHANGE_ID\";/" ./sv/media_interface/common/mediaSdk_version.cpp
sed -i "s/static std::string versionCode = \".*\";/static std::string versionCode = \"$CHANGE_ID\";/" ./sv/device_sdk/deviceSdk_version.cpp

make -j$(nproc) sv/app/dummy_clean
make -j$(nproc) sv/app/dummy

mkdir -p out/sv/sdk
mkdir -p out/sv/sdk/libs
mkdir -p out/sv/sdk/device_sdk/include
mkdir -p out/sv/sdk/device_sdk/lib
mkdir -p out/sv/sdk/media_sdk/include
mkdir -p out/sv/sdk/media_sdk/lib

cp -v sv/device_sdk/include/* out/sv/sdk/device_sdk/include/
cp -v sv/libs/dynamic/libjsoncpp.so out/sv/sdk/device_sdk/lib/

cp -v sv/media_interface/include/* out/sv/sdk/media_sdk/include/

cp -v out/arm64/libs/dynamic/libdevice_sdk.so out/sv/sdk/device_sdk/lib/
cp -v out/arm64/libs/dynamic/libmedia_interface.so out/sv/sdk/media_sdk/lib/
cp -v out/arm64/libs/dynamic/libmi_internal.so out/sv/sdk/media_sdk/lib/
cp -v out/arm64/libs/dynamic/libutils.so out/sv/sdk/media_sdk/lib/

cp -v ../../../project/release/chip/i7/ipc/common/glibc/10.2.1/mi_libs/dynamic/* out/sv/sdk/libs/
cp -v ../../../project/release/chip/i7/sigma_common_libs/glibc/10.2.1/dynamic/* out/sv/sdk/libs/
rm -rvf out/sv/sdk/libs/libcam_fs_wrapper.so
rm -rvf out/sv/sdk/libs/libcam_os_wrapper.so

echo "==============================================="
echo "             Build SV SDK done!!!"
echo "==============================================="
