### Shell Script Backup

This repository contains a shell script for backing up important data. The script can be used to backup the contents of a folder and its subdirectories, as well as databases.

### Prerequisites

The following tools are required to run the script:

- zip
- mysqldump
- rsync (optional)
- ssh (optional)

### Usage

To use the script, simply run the following command:

```sh
./backup.sh
```

The script creates a backup of the folder and databases in the format backup_YYYY-MM-DDHH-MM-SS, where YYYY-MM-DDHH-MM-SS is the current date and time. The backups are stored in the /home/9walls-backups directory.

The script also includes optional support for sending the backups to a remote server via rsync and ssh. To enable this feature, make sure to fill in the necessary information in the script, such as the remote user, hostname/IP address, and remote destination.

This script can be scheduled to run automatically using the cron command. For example, if you want to run the script every Sunday at 5am, you can add the following line to the cron configuration file:

```sh
0 5 * * 0 /home/9walls-backups/backup.sh
```

This is just one example of how the backup script can be used. Feel free to customize it to your specific needs. If you have any questions or need help, don't hesitate to open an issue on Github.

### Contributing

If you wish to contribute to this project, feel free to submit a pull request with your changes. Any improvements or bug fixes are welcome.

### License

This project is licensed under the [MIT license](https://opensource.org/licenses/MIT).
