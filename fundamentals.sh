#!/bin/bash
# /bin/bash <file_name>


#assigning  variable
word='script'  #not allowed Em@AIL, 3word

#accessing variable
echo "$word" #dont use single quotes here

#using variable in a line
echo " this is first $word"
echo " this is first ${word}"

#appending 
echo "${word}ing is fun"
