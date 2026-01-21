#!/bin/bash

#set threshold
threshold=30

df -Ph | tail -n+2 | while read -r fs size used avail use mount; do
disk_usage=$(echo $use | sed 's/%//' )
if [[ disk_usage -gt $threshold ]]
then
    echo "disk usage $fs is at $use mounted on $mount"
fi
done