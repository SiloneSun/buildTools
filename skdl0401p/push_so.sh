cp /mnt/skdl0401p/lib/*.so /oem/engine/mpp/
cp /mnt/skdl0401p/lib/*.so /customer/libs/
cp /mnt/skdl0401p/lib/module_test /oem/engine/mpp/
cp /mnt/skdl0401p/lib/prog_kmsg_logger /customer/bin/
sync

md5sum /oem/engine/mpp/libmedia_interface.so
md5sum /oem/engine/mpp/libutils.so
md5sum /oem/engine/mpp/libmi_internal.so
md5sum /oem/engine/mpp/libdevice_sdk.so
md5sum /oem/engine/mpp/libjsoncpp.so

