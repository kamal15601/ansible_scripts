#!/bin/bash

echo "you executed this command: ${0}"

#display path and filename of the script

echo "you used $(dirname ${0}) as the path of $(basename ${0})"

#inside the script they are paramaters , outside they are parameters

echo "the number of arguments passed is ${#}"
if [[ "${#}" -le 1 ]]
then 
    echo " please pass arguments ${0} [username] [usrname]..."
    exit 1
fi
