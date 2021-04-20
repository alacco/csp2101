# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initialise all variables to be used by the script and set their values to 0 
files_containing_data=0
empty_files=0
directory_contains_files=0
empty_directories=0
check_for_files=0

# Change the directory to the path enetered by the user
cd $1

# Begin a loop to check each item within the directory entered by the user
for i in `ls `; do
    # Check if an item contains data and is a file
    if [ -s $i ] && [ -f $i ]; then
        # Add one to the number of files found containing data
        files_containing_data=$(($files_containing_data+1))
    # Check if an item does not contain data and is a file
    elif [ ! -s $i ] && [ -f $i ]; then
        # Add one to the number of files found not containing data
        empty_files=$(($empty_files+1))
    # Check if an item is a directory
    elif [ -d $i ]; then
        # Enter the directiry
        cd $1$i
        
        # Count the number of files within the directory and store result
        check_for_files=$(ls | wc -l) 
        
        # Check if number of files is greather then 0
        if [ $check_for_files -gt 0 ] ; then
            # Add one to number of directories containing files
            directory_contains_files=$(($directory_contains_files+1))
        else
            # Add one to number of empty directories
            empty_directories=$(($empty_directories+1))
        fi

        # Exit and return to original directory
        cd ..
    fi
done

# Display results of the above for loop message to the user using the data found
echo -e "The $1 directory contains: "
echo -e "$files_containing_data files that contain data"
echo -e "$empty_files files that are empty"
echo -e "$directory_contains_files non-empty directories"
echo -e "$empty_directories empty directories"

# Exit script if no errors occurred 
exit 0