#!/usr/bin/env bash

# Change to the directory containing the script and source the .env file
cd "$(dirname "$0")" &&
	source .env

# Get the list of upgradable packages and count the lines, suppressing warnings
/usr/bin/sudo /usr/bin/apt-get update >/dev/null || true
upgradable_list=$(/usr/bin/sudo /usr/bin/apt list --upgradable 2>/dev/null || true)
updates=$(echo "${upgradable_list}" | /usr/bin/grep -c "/")

# Check if there are updates available
if [[ ${updates} -eq 0 ]]; then
	# If no updates are available, send a curl request
	/usr/bin/curl --request GET --url "${UPDATE_APT_CURL}"
fi
