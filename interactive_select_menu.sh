#!/bin/bash
#it provides a number menu to select and proceed further
echo "select an option"
#after select the option the syntax is same as CASE
# ;; end of block
select option in start stop Restart Quit; do
    case $option in
        start) echo "service started" ;;
        stop) echo "service stopped" ;;
        Restart) echo "service restarted" ;;
        Quit) break;;
        *) echo "invalid option" ;;
    esac
done

