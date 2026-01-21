#!/bin/bash

#this script demonstrates I/O redirection

file="temp"
head -n1 /etc/passwd > ${file}


#overwriting the file with >
tail -n3 /etc/passwd > ${file}
cat ${file}

#appending to the file with >>
head -n2 /etc/passwd >> ${file}
cat ${file}

#redirect your errors (stderr) with 2>filename



#redirect both output and error messages to same place
#&> filename it is similart to below

head -n1 /etc/passwd /etc/hosts /flfjdklj > ${file} 2>&1

cat ${file}
