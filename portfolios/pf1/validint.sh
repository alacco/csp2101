# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

valid_input=false

until [ "$valid_input" = true ]; do
    read -p 'Please enter a two digit numeric code [Either 20 or 40]: ' numeric_code

    if [[ $numeric_code =~ ^[0-9]+$ ]] && [[ $numeric_code -eq 20 ]] || [[ $numeric_code -eq 40 ]]; then
        echo 'Valid numeric code entered'
        valid_input=true
    else
        echo -e 'Not a valid numeric code try again. \n'
    fi
done

exit 0