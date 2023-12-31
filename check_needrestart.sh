#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Run the needrestart command and store the output
output=$(/usr/bin/sudo /usr/sbin/needrestart -p)

# Check if the output starts with "OK - "
if [[ ${output} == "OK - "* ]]; then
	# If it starts with "OK - ", send a curl request
	/usr/bin/curl --request GET --url "${NEEDRESTART_CURL}"
fi
