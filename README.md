# Health-checks

This repository contains a set of Bash scripts for performing health checks on a Linux system. These scripts monitor various aspects of the system, including CPU usage, RAM usage, disk space, process count, SWAP usage, uptime, and more. The purpose of these scripts is to help you monitor the health of your Linux server and take appropriate actions based on predefined thresholds.

## Features

- **CPU load**: Keep tabs on CPU load averages and receive alerts when they surpass predefined limits.
- **Disk usage**: Monitor free disk space, triggering alerts if it drops below a specified threshold.
- **Service failed**: Receive alerts if any service failed.
- **Memory usage**: Monitor RAM usage and receive alerts if it exceeds a set limit to optimize system performance.
- **Needrestart**: Monitor the need for system restarts and receive alerts if necessary, ensuring system stability.
- **Process count**: Keep a check on the number of running processes and receive alerts if it exceeds a predefined limit.
- **SWAP usage**: Monitor SWAP usage and receive alerts if it surpasses a specified threshold to maintain optimal system functionality.
- **Update (APT)**: Stay informed about available updates through APT and receive alerts for timely system maintenance.
- **Uptime**: Keep track of system uptime and receive alerts if it extends beyond a specified limit to maintain system reliability.
- **Reboot required**: Check whether a restart is required. If yes, a restart will be carried out in 24 hours.

## Prerequisites

Before you get started, ensure you have the following prerequisites:

- Install Git: `sudo apt update && sudo apt install git`
- A health-check provider

## Installation

1. Create a user for the health-check scripts.
2. Create the directory `mkdir -p /opt/git`.
3. Change to the directory `cd /opt/git`.
4. Clone this repository using the following command: `git clone https://github.com/cubyverse/health-checks.git`
5. Log in as the user with whom the scripts are to be executed.
6. Change to the directory `cd /opt/git/health-checks`.
7. Run the installation script: `./installation.sh`

## Usage

- Perform a Git pull to ensure you have the latest updates: `git pull`
- Customize settings by running the script `./installation.sh` or by editing the `.env` file.

## Automated script execution

1. Create a user for health-checks.
2. Configure the sudo permissions. Open the sudoers file: `vi /etc/sudoers.d/health-check` and paste the content into the file.

```bash
health-check ALL=(ALL) NOPASSWD: /usr/sbin/needrestart -p
health-check ALL=(ALL) NOPASSWD: /usr/bin/apt-get update
health-check ALL=(ALL) NOPASSWD: /usr/bin/apt list --upgradable
```

3. Configure the crontab. Open the crontab file: `vi /etc/cron.d/health-checks` and paste the content into the file.

```bash
*/5 * * * *     health-check	/opt/git/health-checks/check_memory_usage.sh >/dev/null 2>&1
*/5 * * * *     health-check	/opt/git/health-checks/check_cpu_load.sh >/dev/null 2>&1
*/5 * * * *     health-check	/opt/git/health-checks/check_swap_usage.sh >/dev/null 2>&1
*/5 * * * *     health-check	/opt/git/health-checks/check_disk_usage.sh >/dev/null 2>&1
*/5 * * * *     health-check	/opt/git/health-checks/check_process_count.sh >/dev/null 2>&1
*/15 * * * *    health-check	/opt/git/health-checks/check_service_failed.sh >/dev/null 2>&1
0 */6 * * *     health-check	/opt/git/health-checks/check_needrestart.sh >/dev/null 2>&1
0 */12 * * *	health-check	/opt/git/health-checks/check_update_apt.sh >/dev/null 2>&1
0 */24 * * *	health-check	/opt/git/health-checks/check_reboot_required.sh >/dev/null 2>&1
0 */24 * * *	health-check	/opt/git/health-checks/check_uptime.sh >/dev/null 2>&1
```

## Contributing

We welcome contributions from the community. To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch.
3. Make your enhancements or fixes.
4. Submit a pull request.
