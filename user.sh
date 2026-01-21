#!/bin/bash
#
##display the UID and username of the user executing this script


#display the uid
echo "the uid is ${UID}"

#display the username
echo "the username is $(whoami)"

echo `whoami` #we can run the command like this


echo "${UID}"
#display the user is root or not
if [[ "$(whoami)" == "root" ]]   #if [["${UID}" -eq 0]]
then
    echo "you are root"
else
    echo "you are not roo
    
fi




