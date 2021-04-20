# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initialise a variable to be used the control variable for the main loop
# and set its value to false 
valid_input=false

# Enter the main application loop user enter valid input
until [ "$valid_input" = true ]; do
    # Ask the user to enter a two digit code and store it in a variable
    read -p 'Please enter a two digit numeric code [Either 20 or 40]: ' numeric_code

    # Check if the code entered by the user is 20 or 40, if so print valid code message
    # and set vaild_input to true (ending the loop) else tell the user to try again 
    # and continue the loop
    if [[ $numeric_code =~ ^[0-9]+$ ]] && [[ $numeric_code -eq 20 ]] || [[ $numeric_code -eq 40 ]]; then
        echo 'Valid numeric code entered'
        valid_input=true
    else
        echo -e 'Not a valid numeric code try again. \n'
    fi
done

# Exit script if no errors occurred 
exit 0