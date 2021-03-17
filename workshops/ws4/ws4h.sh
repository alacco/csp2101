#!/bin/bash

read -p 'Please enter a number of any length: ' number

if [[ $number =~ ^[0-9]+$ ]]; then
    echo "Congrats, you habe entered a valid number"
else
    echo "That was not a number"
    exit 1
fi

exit 0