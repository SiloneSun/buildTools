
catVif()
{
    echo "cat /sys/class/mstar/vif0/vif_ints"
    cat /sys/class/mstar/vif0/vif_ints

    echo "cat /sys/class/mstar/vif0/vif_info"
    cat /sys/class/mstar/vif0/vif_info
}

catVif
sleep 1
catVif
sleep 1
catVif