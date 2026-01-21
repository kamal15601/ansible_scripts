#!/bin/bash

#this script demonstrates the case statements

#if [[ "${1}" = "start" ]]
#then
#    echo "starting..."
#elif [[ "${1}" = "stop" ]]
#then
#    echo "stopping..."
#elif [[ "${1}" = "run" ]]
#then
#    echo "running..."
##else
  #  echo "supply a valid argument" >&2
   # exit 1
#fi

#using case statement

case "${1}" in
    start)
        echo "starting..."
        ;;
    stop)
        echo "stopping..."
        ;;
    run|running|--run|--running)
        echo "running..."
        ;;
    *)
        echo "supply a valid argument" >&2
        exit 1
        ;;
esac    


