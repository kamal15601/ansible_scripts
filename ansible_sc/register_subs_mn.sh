#!/bin/bash
echo " this script is used to register redhat subscription"
username="$1"
password="$2"


subscription-manager register --username="$username" --password="$password"

echo " the exit status of last command is $? "