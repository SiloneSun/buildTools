ifconfig eth0 up
udhcpc_output=$(/sbin/udhcpc -b -i eth0 2>&1)
ip_address=$(echo "$udhcpc_output" | awk '/Lease of/{print $3}')
echo "IP : $ip_address"
if [ -n "$ip_address" ]; then
    ifconfig eth0:1 $ip_address netmask 255.255.254.0
else
    echo "Error..."
    exit 1
fi

mount -t nfs 10.66.30.1:/home/sxl/work/share /mnt -o nolock,tcp

