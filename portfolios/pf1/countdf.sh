# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

files_containing_data=0
empty_files=0
directory_contains_files=0
empty_directories=0
check_for_files=0

cd $1

echo -e "The $1 directory contains: "

for i in `ls `; do
    if [ -s $i ] && [ -f $i ]; then
        files_containing_data=$(($files_containing_data+1))
    elif [ ! -s $i ] && [ -f $i ]; then
        empty_files=$(($empty_files+1))
    elif [ -d $i ]; then
        cd $1$i
        check_for_files=$(ls | wc -l) 
        
        if [ $check_for_files -gt 0 ] ; then
            directory_contains_files=$(($directory_contains_files+1))
        else
            empty_directories=$(($empty_directories+1))
        fi
        cd ..
    fi
done
echo -e "$files_containing_data files that contain data"
echo -e "$empty_files files that are empty"
echo -e "$directory_contains_files non-empty directories"
echo -e "$empty_directories empty directories"

exit 0