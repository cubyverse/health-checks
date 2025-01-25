#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Calculate the percentage of free disk space
DISK_USAGE=$(df -h / | awk 'FNR == 2 {print $5}') || true
DISK_USAGE=${DISK_USAGE//%/}
FREE_DISK_USAGE=$((100 - DISK_USAGE))

# Check if free disk usage is greater than or equal to the specified limit
if [[ ${FREE_DISK_USAGE} -ge ${DISK_USAGE_LIMIT} ]]; then
	# Send a GET request using curl to the specified URL for high disk usage
	/usr/bin/curl --request GET --url "${DISK_USAGE_CURL}"
fi
