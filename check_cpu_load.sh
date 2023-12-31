#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Retrieve the load averages from /proc/loadavg
CPU_LOAD_AVGs=($(cat /proc/loadavg | awk '{print $1, $2, $3}'))

# Initialize a variable to check if all load averages are within the limits
ALL_CPU_LOADS_OK=true

# Iterate through the load averages and their corresponding limits
for i in 0 1 2; do
	CPU_LOAD_AVG=$(printf "%.0f" "${CPU_LOAD_AVGs[i]}")
	CPU_LOAD_LIMIT=${CPU_LOAD_LIMITS[${i}]}

	# Check if the load average exceeds the specified limit
	if [[ ${CPU_LOAD_AVG} -gt ${CPU_LOAD_LIMIT} ]]; then
		ALL_CPU_LOADS_OK=false
		break
	fi
done

# If all load averages are within the limits, send a GET request using curl
if ${ALL_CPU_LOADS_OK}; then
	/usr/bin/curl --request GET --url ${CPU_LOAD_CURL}
fi
