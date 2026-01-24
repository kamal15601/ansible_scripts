#!/bin/bash

#set threshold
threshold=40
logfile="/var/log/disk_monitor.log"
#alert_mail="example@gmial.com"

df -Ph | awk 'NR>1 {print $5, $6}' | while read -r usage mount; do
    #usage1=$( echo "$usage" | sed 's/%//')
    #See if you can use ${variable//search/replace} instead.
    usage=${usage%\%}
    if [ "$usage" -gt $threshold ]; then
        msg="$(date '+%F %T') - ALERT: $mount is at $usage% usage"
        echo "$msg" >> "$logfile"
        echo "warning: your disk is at $usage% mounted on $mount"
        #sending mail
        #echo "$msg" | mail -s "Disk Usage Alert: $mount" "$alert_mail"
        #log to syslog
        logger -t disk_monitor "$msg"
    else
        msg="$(date '+%F %T') - OK: $mount is at $usage% usage"
        echo "$msg" >> $logfile
        logger -t disk_monitor "$msg"
    fi
    
done