#!/bin/bash
flag=1
isProcRunning() {
    proc_name=$1
    proc_id=$(pgrep $proc_name)
    length=$(expr length "$proc_id")
    if [[ $length -eq 0 ]]; then
        flag=1
    fi
}
killProc() {
    proc_name=$1
    proc_id=$(pgrep $proc_name)
    length=$(expr length "$proc_id")
    if [[ $length -gt 0 ]]; then
        kill $proc_id
        sleep 2
    fi
}
checkProcStatus() {
    flag=0
    isProcRunning prog_msg_forwarder
    isProcRunning prog_usbcam
    isProcRunning prog_discovery_server
    isProcRunning prog_device
    isProcRunning prog_api_server
    isProcRunning prog_kmsg_logger

    if [ "$flag" -eq 1 ]; then
        echo "Listener: Restart all worker processes..."
        killProc prog_msg_forwarder
        killProc prog_usbcam
        killProc prog_discovery_server
        killProc prog_device
        killProc prog_api_server
        killProc prog_kmsg_logger
        /customer/prog_msg_forwarder &
        /customer/prog_usbcam &
        /customer/prog_discovery_server &
        /customer/prog_device &
        /customer/prog_api_server &
        /customer/prog_kmsg_logger &
    fi
}

counter=0
#while [ $counter -le 5 ]; do
#    checkProcStatus
#    sleep 5
#done
checkProcStatus
