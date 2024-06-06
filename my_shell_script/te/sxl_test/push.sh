cd /userdata/sxl_prog
tftp -gr /sxl_test/prog_api_server 192.168.1.20
tftp -gr /sxl_test/prog_discovery_server 192.168.1.20
tftp -gr /sxl_test/prog_usbcam 192.168.1.20
tftp -gr /sxl_test/www.tar.bz2 192.168.1.20

cd /customer/sxl
sh kill.sh

cp /userdata/sxl_prog/prog_api_server /customer/
cp /userdata/sxl_prog/prog_discovery_server /customer/
cp /userdata/sxl_prog/prog_usbcam /customer/
cp /userdata/sxl_prog/www.tar.bz2 /customer/

chmod 777 /customer/prog_api_server
chmod 777 /customer/prog_discovery_server
chmod 777 /customer/prog_usbcam
chmod 777 /customer/www.tar.bz2