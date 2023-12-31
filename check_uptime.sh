#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Calculate uptime in days from /proc/uptime
UPTIME_DAYS=$(/usr/bin/awk '{print int($1/60/60/24)}' /proc/uptime)

# Check if uptime is less than or equal to the specified uptime limit in days
if [[ ${UPTIME_DAYS} -le ${UPTIME_LIMIT} ]]; then
	# Send a GET request using curl to the specified URL for uptime
	/usr/bin/curl --request GET --url "${UPTIME_CURL}"
fi
