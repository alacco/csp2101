# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Calculate the sum of the three integers entered on the command line
result=$(($1+$2+$3))

# Check if the sum of the entered integers is equal to or less then 30 
# and display required output else display exceeds maximum allowable message
if [[ "$result" -le 30 ]]; then
  echo "The sum of $1 and $2 and $3 is $result"
else
  echo "Sum exceeds maximum allowable"
fi

# Exit script if no errors occurred 
exit 0

