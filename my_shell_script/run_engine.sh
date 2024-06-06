#!/bin/sh
if [ ! $basepath ] ;then
    echo "Relative path Start up"
    basepath=$(cd `dirname $0`; pwd)
else
    echo "Absolute path Start up"
fi

export ALSA_CONFIG_DIR=/oem/engine/mpp
export ALSA_CONFIG_PATH=/oem/engine/mpp/alsa.conf
export PATH=$PATH:/userdata/sxl/usr/local/bin
export VALGRIND_LIB=/userdata/sxl/usr/local/libexec/valgrind/

echo "basepath = $basepath"
cd $basepath

./kill_engine.sh

core_path="/userdata/dump"
limit_core_num=5
total_core_num=`ls -l ${core_path}/*.core | wc -l`
echo "coredump path is: " ${core_path}
echo "limit core num is: " ${limit_core_num}
echo "totol core num is: " ${total_core_num}

#remove the earliest file
if [ "$total_core_num" -gt "$limit_core_num" ]
	then
	del_num=$((total_core_num-limit_core_num))
	echo "del num is: " ${del_num}
	ls -ltr ${core_path}/*.core | grep -v 'total' | awk '{print $9}' | head -n $del_num | xargs rm
fi

#genrate core use name: Name_PID_UnixTimeStamp.core
ulimit -c unlimited
sysctl -w kernel.core_pattern=${core_path}/EngineUi_%p_%t.core

# config net
ifconfig eth0 up
ifconfig eth1 up
ifconfig lo 127.0.0.1/24

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$basepath/engine:$basepath/engine/3rdparty:$basepath/engine/mpp:/config/lib
chmod +x engine/EngineUi

INPUT_PARA=$1
echo Input Para: $INPUT_PARA

# 如果日志文件夹不存在，则提前创建日志文件夹，避免守护进程和主进程同时尝试去创建日志文件夹时，一方创建失败后导致日志模块初始化失败问题
if [ ! -d "/userdata/log/engine" ]; then
  mkdir -p /userdata/log/engine
fi

if [ -n ${INPUT_PARA} ] && [ "-s" == ${INPUT_PARA} ];then
    echo "open console output"
    ./engine/EngineUi &
else
    echo "close console output"
    ./engine/EngineUi --logname=EngineUi --logpath=/userdata/log/engine/ &
fi
