#!/bin/bash

#check the script is running with root privileges
if [[ "${UID}" -ne 0 ]]
then
    echo "please run this script with root privileges"
    exit 1
fi

#ask for username
#read -p 'enter your username: ' username
#ask for realname
#read -p 'enter your fullname: ' fullname

#generate password with random command
char=
rand_char=$(echo "!@#$%^&*()_+=-" | fold -w1 | shuf | head -c1)
password="$(date +%s%N | sha256sum | head -c8 )${rand_char}"

#create the user
useradd -c "${1}" -m ${2}

#check the user is created or not
if [[ "${?}" -ne 0 ]]
then
    echo "the user is not created"
    exit 1
fi

#set password
echo "${2}:${password}" | chpasswd 

#check the password setup is success or not
if [[ "${?}" -ne 0 ]]
then
    echo "password setup is not completed"
    exit 1
fi

#force the user to change the password
passwd -e ${2}


echo
echo "the username is: ${2}"
echo
echo "the fullname is: ${1}"
echo
echo "the password is:"
echo ${password}
echo "the hostname is: "
echo $(hostname)




