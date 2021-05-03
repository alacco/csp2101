# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# This function is used to process the input by the userfile
getprop()
{
    # Count the number of words within the file and store as word_count
    word_count=$(wc -w <"$1")
    # Calculate the size of the file in bytes, convert to kilobytes and store as file_size
    file_size=$(echo "scale=3; $(wc -c <"$1") / 1000" | bc -l)
    # Check the last modified date of the file and store as last_modified_date
    last_modified_date=$(date -r $1 +"%d-%m-%Y %H:%M:%S")
    # Display the results back to the user on screen
    echo -e "The file $1 contains $word_count words and is $file_size \bK in size and was last modified $last_modified_date" 
}

# Ask the user for a file they want check and store in file_name
read -p 'Enter the name of file you want to check: ' file_name

# Send the file name to the getprop function
getprop $file_name

# Exit script if no errors occurred 
exit 0