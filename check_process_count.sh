#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Count the number of running processes
PROCESS_COUNT=$(/usr/bin/ps -ef || true)
PROCESS_COUNT=$(echo "${PROCESS_COUNT}" | wc -l)

# Check if the process count is less than or equal to the specified limit
if [[ ${PROCESS_COUNT} -le ${PROCESS_COUNT_LIMIT} ]]; then
	# Send a GET request using curl to the specified URL for process count
	/usr/bin/curl --request GET --url "${PROCESS_COUNT_CURL}"
fi
