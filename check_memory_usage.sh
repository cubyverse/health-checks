#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Calculate the percentage of memory usage
FREE_MEMORY_USAGE=$(/usr/bin/free | /usr/bin/awk '/Mem:/ {printf("%.0f"), (1 - $3/$2) * 100}')

# Check if memory usage exceeds the specified memory limit
if [[ ${FREE_MEMORY_USAGE} -ge ${MEMORY_USAGE_LIMIT} ]]; then
	# Send a GET request using curl to the specified URL for high memory usage
	/usr/bin/curl --request GET --url "${MEMORY_USAGE_CURL}"
fi
