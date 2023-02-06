#!/bin/bash

# This script will backup the storage folder and the database of 9walls-tenant

# Date format: YYYY-MM-DDHH-MM-SS
now=$(date +"%Y-%m-%d%H-%M-%S")

# Create a folder for the storage and database backup
storage_folder="/home/9walls-backups/storage_$now"
db_folder="/home/9walls-backups/db_$now"

# Create the folder if it doesn't exist
if [ ! -d "$storage_folder" ]; then
  mkdir -p "$storage_folder"
fi

# Backup the storage folder
for dir in /var/www/9walls-tenant/storage/*/; do
  dir_name="$(basename "${dir}")"
  zip -r "$storage_folder/${dir_name}_$now.zip" "$dir"
done

#Database credentials
mysql_user=root
mysql_password=root

# Get all databases
databases=$(mysql -u "$mysql_user" -p"$mysql_password" -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)")

# Create the folder if it doesn't exist
if [ ! -d "$db_folder" ]; then
  mkdir -p "$db_folder"
fi

# Backup the databases
for db in $databases; do
  mysqldump --user=root --password=root "$db" > "$db_folder/${db}_$now.sql"
done

# Sync the backups to the remote server
remote_user="<username>"
remote_host="<hostname or IP address>"
remote_dest="/path/to/remote/destination"

rsync -avz --ignore-existing /home/9walls-backups/ "$remote_user@$remote_host:$remote_dest"

# Delete the backups older than 30 days
find /home/9walls-backups/* -mtime +30 -exec rm -rf {} \;

# Delete the backups older than 30 days on the remote server
ssh "$remote_user@$remote_host" "find $remote_dest/* -mtime +30 -exec rm -rf {} \;"


# Add the script to the crontab
# crontab -e
# Add the following line to the crontab to execute the script every 7 days at 5:00 AM
# 0 5 * * 0 /home/9walls-backups/backup.sh
