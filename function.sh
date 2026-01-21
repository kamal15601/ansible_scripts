#!/bin/bash

#create log function[function log or log()]

log() {
    local verbose="${1}"
    shift
    local message="${@}"
    if [[ "${verbose}" == "true" ]]
    then
        echo "${message}"
    fi
    logger -t function.sh "${message}"
}

#this fun creates a backupfile . returns non-zero status on error
backup_file() {
    local file="${1}"
#make sure the file exists.
if [[ -f "${file}" ]]
then
    local backup_file="/var/tmp/$(basename ${file}).$(date +%F-%N)"
    
    log "${verbose}" "Backing up ${file} to ${backup_file}."

    #exit status of function will be exit status of cp command
    cp -p "${file}" "${backup_file}"
else
    #the file does not exist
    return 1
fi

}


verbose="true"
log "${verbose}" "hello"
log "hi" "bye"

backup_file "${1}"

if [[ ${?} -eq 0 ]]
then
    echo "backup succeed"
    exit 0
else
    echo "backup failed"
    exit 1
fi