#!/bin/bash
flag=1
isProcRunning() {
    killname=$1
    killid=$(pgrep $killname)
    length=$(expr length "$killid")
    # echo "isProcRunning: [$killname][$killid][$length]"
    if [[ $length -eq 0 ]]; then
        flag=1
    fi
}
killProc() {
    killname=$1
    killid=$(pgrep $killname)
    length=$(expr length "$killid")
    # echo "killProc: [$killname][$killid][$length]"
    if [[ $length -gt 0 ]]; then
        kill $killid
        sleep 1
    fi
}
doWork() {
    # echo "doWork enter."
    flag=0
    # echo "doWork: flag=[$flag]"
    isProcRunning prog_msg_forwarder
    isProcRunning prog_usbcam
    isProcRunning prog_discovery_server
    isProcRunning prog_device
    isProcRunning prog_api_server
    isProcRunning prog_kmsg_logger
    # echo "doWork: flag=[$flag]"

    if [ "$flag" -eq 1 ]; then
        echo "MONITOR: RESTART ALL PROGRAM..."
        killProc prog_msg_forwarder
        killProc prog_usbcam
        killProc prog_discovery_server
        killProc prog_device
        killProc prog_api_server
        killProc prog_kmsg_logger
        sleep 1
        /customer/prog_msg_forwarder &
        /customer/prog_usbcam &
        /customer/prog_discovery_server &
        /customer/prog_device &
        /customer/prog_api_server &
        /customer/prog_kmsg_logger &
    # else
    #     echo "All threads is running..."
    fi
}

counter=0
while [ $counter -le 5 ]; do
    doWork
    sleep 5
done