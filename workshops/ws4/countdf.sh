# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

files_containing_data=0
empty_files=0
directory_contains_files=0
empty_directories=0

echo -e "The $1 directory contains: \n"

for i in `ls $1`; do
    if [ -s $i ] && [ -f $i ]; then
        files_containing_data=$(($files_containing_data+1))
    elif [ ! -s $i ] && [ -f $i ]; then
        empty_files=$(($empty_files+1))
    elif [ -d $i ]; then
        directory_contains_files=$(($directory_contains_files+1))
    fi
done
echo -e "$files_containing_data files that contain data\n"
echo -e "$empty_files files that are empty\n"
echo -e "$directory_contains_files non-empty directories\n"
exit 0