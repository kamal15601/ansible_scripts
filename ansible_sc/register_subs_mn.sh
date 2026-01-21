#!/bin/bash
echo " this script is used to register redhat subscription"
username="$1"
password="$2"

if [[ $# -lt 2 ]]
then
    echo "please provide username and password as arguments to proceed further"
    exit 1
fi

if [[ $(id -u) -ne 0 ]]
then
    echo "please run this script as root"
    exit 1
fi


subscription-manager register --username="$username" --password="$password"

echo " the exit status of last command is $? "