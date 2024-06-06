LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/oem/engine/mpp
./module_test -7 &
sleep 15
PID=$(pgrep module_test)
if [ -n "$PID" ]; then
	kill -SIGTSTP $PID
else
	echo "Please Ctrl+Z exit!"
fi
