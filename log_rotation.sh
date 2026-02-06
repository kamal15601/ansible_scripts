#!/bin/bash
log_file="/var/log/large_files.log"
max_days=7
backup_location="/var/log/log_backup"

#check whether the script running with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "please run this script as root"
    exit 1
fi

#moving logfile to backup_dir
#compressing the log files in backup_dir
#delteing log files older than 7 days
#creating new log file in original location

#Ensure backup directory is present it creates or ignores
#based on check
mkdir -p $backup_location

#create timestamp to append logfile 
timestamp=$(date +%F_%T)

if [ -f "$log_file" ]; then
    mv "$log_file" $backup_location/large_files_"$timestamp".log
    gzip $backup_location/large_files_"$timestamp".log
fi

#creating new empty log file at original location
touch "$log_file"
chmod 0644 "$log_file"

#deleting log files older than 7 days
check_and_delete() {
find $backup_location -type f -name "*.gz" -mtime "$max_days" \
-exec rm -f {} \;
}



#checking exit code of last commnad whether the script is sucessful
if check_and_delete; then
    echo "log rotation is successful"
else
    echo "log rotation failed"
fi

