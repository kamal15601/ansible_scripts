#!/bin/bash
search_path="/"
log_file="/var/log/large_files.log"
min_size=100M
top_n=20


find $search_path -type f -size $min_size -exec ls -lh {} \; 2>/dev/null \
| awk '{print $9, $5}' \
| head -n $top_n \
| sort -hr -k2 >> $log_file

#remove duplicates
sort -u -o "$log_file" "$log_file"

cat $log_file
echo "Report saved to $log_file"