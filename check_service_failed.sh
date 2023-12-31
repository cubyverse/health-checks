#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Run systemctl --failed and store the output
SERVICES_FAILED=$(/usr/bin/systemctl --failed)

# Check if the output contains "0 loaded units listed"
if [[ ${SERVICES_FAILED} == *"0 loaded units listed."* ]]; then
	# If no failed services are found, send a curl request
	/usr/bin/curl --request GET --url "${SERVICE_FAILED_CURL}"
fi
