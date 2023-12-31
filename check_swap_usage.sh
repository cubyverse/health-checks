#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Calculate the percentage of swap usage
SWAP_USAGE=$(/usr/bin/free | /usr/bin/awk '/Swap:/ {printf("%.0f"), $3/$2 * 100}')

# Check if swap usage is less than the specified swap limit
if [[ ${SWAP_USAGE} -lt ${SWAP_USAGE_LIMIT} ]]; then
	# Send a GET request using curl to the specified URL for swap
	/usr/bin/curl --request GET --url "${SWAP_USAGE_CURL}"
fi
