#!/usr/bin/env bash

ENV_FILE=".env"

# Function to interactively get a URL from the user
get_and_validate_url() {
	local prompt="$1"
	local url

	while true; do
		read -p "${prompt}: " url

		# Validate URL
		if [[ ${url} =~ ^https?:// ]]; then
			echo "${url}"
			break
		fi
	done
}

# Function to prompt the user regarding the existing .env file
prompt_for_existing_env_file() {
	local choice

	read -p ".env file already exists. Do you want to delete, overwrite, or exit the script? (d/o/e): " choice

	case "${choice}" in
	d | D)
		rm -f "${ENV_FILE}"
		;;
	o | O) ;;
	e | E)
		echo "Exiting the script."
		exit 0
		;;
	*)
		echo "Invalid choice. Exiting the script."
		exit 1
		;;
	esac
}

# Function to write the configuration to the .env file
write_to_env_file() {
	echo "$1=$2" >>"${ENV_FILE}"
}

# Check if .env file already exists
if [[ -e ${ENV_FILE} ]]; then
	prompt_for_existing_env_file
fi

# Ask the user for each URL and write to the .env file
write_to_env_file "CPU_LOAD_CURL" "$(get_and_validate_url "Enter CPU load URL")"
write_to_env_file "DISK_USAGE_CURL" "$(get_and_validate_url "Enter Disk usage URL")"
write_to_env_file "SERVICE_FAILED_CURL" "$(get_and_validate_url "Enter Service failed URL")"
write_to_env_file "MEMORY_USAGE_CURL" "$(get_and_validate_url "Enter Memory usage URL")"
write_to_env_file "NEEDRESTART_CURL" "$(get_and_validate_url "Enter Needrestart URL")"
write_to_env_file "PROCESS_COUNT_CURL" "$(get_and_validate_url "Enter Process count URL")"
write_to_env_file "SWAP_USAGE_CURL" "$(get_and_validate_url "Enter Swap usage URL")"
write_to_env_file "UPDATE_APT_CURL" "$(get_and_validate_url "Enter Update APT URL")"
write_to_env_file "UPTIME_CURL" "$(get_and_validate_url "Enter Uptime URL")"
write_to_env_file "REBOOT_REQUIRED_CURL" "$(get_and_validate_url "Enter Reboot required URL")"

echo "Configuration has been written to ${ENV_FILE}."
