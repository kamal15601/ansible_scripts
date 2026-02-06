#!/bin/bash

#set -e exit immediately on error
#set -u treat unset variable as error
#set -o pipefail >> fails if any command fails in pipeline


#redirect errors to error.log
exec 2>error.log

trap 'echo "Error occurred at line $LINENO"; exit 1' ERR
#echo "variable is $number"
ls tmp/tmp/
set -u
whoami
pwd

#you can combine with exec >output.log 2>&1 to redirect both
#both stdout and stderr into one file
#create function to handle errors

error_exit() {
  echo "Error: $1"
  exit 1
}

cp /nonexistent/file /tmp/ || error_exit "Copy failed"


