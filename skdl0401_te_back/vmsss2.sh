#!/bin/bash

# Function to calculate percentage change
calculate_percentage_change() {
    local old_value=$1
    local new_value=$2

    # Remove "kB" from values and convert to integers
    old_value=${old_value%" kB"}
    new_value=${new_value%" kB"}

    # Check if old_value is zero to avoid division by zero
    if [ $old_value -eq 0 ]; then
        echo "N/A"
    else
        local percentage_change=$(( (new_value - old_value) * 100 / old_value ))
        echo "$percentage_change"
    fi
}

# Function to read previous memory values from file
read_previous_values() {
    local pid=$1
    local type=$2

    # Check if file exists
    if [ -f "/tmp/$pid.$type" ]; then
        cat "/tmp/$pid.$type"
    else
        echo "0 kB"
    fi
}

# Function to write current memory values to file
write_current_values() {
    local pid=$1
    local type=$2
    local value=$3

    echo "$value" > "/tmp/$pid.$type"
}

# Loop indefinitely
while true; do
    # Loop through the provided PIDs
    for pid in "$@"; do
        # Get memory usage info
        mem_info=$(cat /proc/$pid/status | grep -E "VmRSS|VmSize")

        # Extract memory values
        time=$(date +"%Y-%m-%d-%H:%M:%S")
        vmrss=$(echo "$mem_info" | awk '/VmRSS/ {print $2}')
        vmsize=$(echo "$mem_info" | awk '/VmSize/ {print $2}')

        # Read previous memory values from file
        previous_vmrss=$(read_previous_values "$pid" "vmrss")
        previous_vmsize=$(read_previous_values "$pid" "vmsize")

        # Print memory usage info
        if [[ "$previous_vmrss" == "0 kB" ]] || [[ "$previous_vmsize" == "0 kB" ]]; then
            echo "PID: $pid | Time: $time | VmRSS: $vmrss kB | VmSize: $vmsize kB"
        else
            vmrss_change=$(calculate_percentage_change "$previous_vmrss" "$vmrss")
            vmsize_change=$(calculate_percentage_change "$previous_vmsize" "$vmsize")
            echo "PID: $pid | Time: $time | VmRSS: $vmrss kB | VmSize: $vmsize kB | VmRSS Change: $vmrss_change% | VmSize Change: $vmsize_change%"
        fi

        # Write current values to file for next iteration
        write_current_values "$pid" "vmrss" "$vmrss"
        write_current_values "$pid" "vmsize" "$vmsize"
    done

    # Sleep for 1 second before next iteration
    echo "------------------------------------------------------------------"
    sleep 1
done
