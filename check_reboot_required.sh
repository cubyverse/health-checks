#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Check if reboot is required
if [[ -f /var/run/reboot-required ]]; then
	echo "/usr/sbin/reboot" | at now + 24 hours
else
	/usr/bin/curl --request GET --url "${REBOOT_REQUIRED_CURL}"
fi
