#!/bin/sh

ergodicFunc2()
{
	echo "cat /sys/class/mstar/msys/TEMP_R"
	cat /sys/class/mstar/msys/TEMP_R

	echo "cat /proc/mi_modules/mi_sensor/mi_sensor0"
	cat /proc/mi_modules/mi_sensor/mi_sensor0

	echo "cat /sys/class/mstar/vif0/vif_ints"
	cat /sys/class/mstar/vif0/vif_ints

	echo "cat /sys/class/mstar/vif0/vif_info"
	cat /sys/class/mstar/vif0/vif_info

	echo "cat /sys/class/mstar/vif1/vif_ints"
	cat /sys/class/mstar/vif1/vif_ints

	echo "cat /sys/class/mstar/vif1/vif_info"
	cat /sys/class/mstar/vif1/vif_info

	echo "cat  /proc/mi_modules/mi_vif/mi_vif0"
	cat  /proc/mi_modules/mi_vif/mi_vif0

	echo "cat  /proc/mi_modules/mi_vif/mi_vif8"
	cat  /proc/mi_modules/mi_vif/mi_vif8

	echo "cat  /proc/mi_modules/mi_vif/mi_vif16"
	cat  /proc/mi_modules/mi_vif/mi_vif16

	echo "cat /sys/class/mstar/isp0/isp_ints"
	cat /sys/class/mstar/isp0/isp_ints

	echo "cat /sys/class/mstar/isp1/isp_ints"
	cat /sys/class/mstar/isp1/isp_ints

	echo "cat  /proc/mi_modules/mi_isp/mi_isp0"
	cat  /proc/mi_modules/mi_isp/mi_isp0

	echo "cat /proc/mi_modules/mi_isp/mi_isp1"
	cat /proc/mi_modules/mi_isp/mi_isp1

	echo "cat /proc/mi_modules/mi_ldc/mi_ldc0"
	cat /proc/mi_modules/mi_ldc/mi_ldc0

	echo "cat /proc/mi_modules/mi_ldc/mi_ldc1"
	cat /proc/mi_modules/mi_ldc/mi_ldc1

	echo "cat /proc/mi_modules/mi_scl/mi_scl0"
	cat /proc/mi_modules/mi_scl/mi_scl0

	echo "cat /proc/mi_modules/mi_scl/mi_scl1"
	cat /proc/mi_modules/mi_scl/mi_scl1
	
	echo "cat /proc/mi_modules/mi_scl/mi_scl2"
	cat /proc/mi_modules/mi_scl/mi_scl2

	echo "cat /proc/mi_modules/mi_scl/mi_scl3"
	cat /proc/mi_modules/mi_scl/mi_scl3

	echo "cat /proc/mi_modules/mi_scl/mi_scl4"
	cat /proc/mi_modules/mi_scl/mi_scl4

	echo "cat /proc/mi_modules/mi_scl/mi_scl5"
	cat /proc/mi_modules/mi_scl/mi_scl5
	
	echo "cat /proc/mi_modules/mi_vdisp/mi_vdisp0"
	cat /proc/mi_modules/mi_vdisp/mi_vdisp0
	
	echo "cat /proc/mi_modules/mi_disp/mi_disp0"
	cat /proc/mi_modules/mi_disp/mi_disp0

	echo "cat /proc/mi_modules/mi_venc/mi_venc0"
	cat /proc/mi_modules/mi_venc/mi_venc0

	echo "cat /proc/mi_modules/mi_venc/mi_venc1"
	cat /proc/mi_modules/mi_venc/mi_venc1

	echo "cat /proc/mi_modules/mi_venc/mi_venc8"
	cat /proc/mi_modules/mi_venc/mi_venc8

	echo "cat /proc/mi_modules/mi_venc/mi_venc9"
	cat /proc/mi_modules/mi_venc/mi_venc9
	
	echo "cat /proc/mi_modules/mi_vdec/mi_vdec0"
	cat /proc/mi_modules/mi_vdec/mi_vdec0
	
	echo "cat /proc/mi_modules/mi_vdec/mi_vdec1"
	cat /proc/mi_modules/mi_vdec/mi_vdec1
}

ergodicFunc2
sleep 1
ergodicFunc2



