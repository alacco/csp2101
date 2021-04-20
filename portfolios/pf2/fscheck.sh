# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

getprop()
{
    word_count=$(wc -w <"$1")
    file_size=$(echo "scale=3; $(wc -c <"$1") / 1000" | bc -l)
    last_modified_date=$(date -r $1 +"%d-%m-%Y %H:%M:%S")
    echo -e "The file $1 contains $word_count words and is $file_size \bK in size and was last modified $last_modified_date" 
    
}

read -p 'Enter the name of file you wish to check: ' file_name
getprop $file_name