# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Run the awk command using \t as the column/data separator
awk 'BEGIN {FS="\t"}
    # Skip the first line within the file
    NR>1 { 
        # Remove any carrage returns from the file (mainly on DOS formatted files)
        sub("\r$", "");
        # Check if $2 (the password) contains a number, an uppercase letter,
        # a lowercase letter and is more than 8 characters long  
        if (length($2)>=8 && match($2,/[A-Z]/) && match($2,/[0-9]/))      
        {
            # If true display the password and message that it meets the requirements
            printf "%-12s - meets password strength requirements\n", $2 
        } else {
            # Else display the password and message that it does nont meet the requirements
            printf "%-12s - does NOT meet password strength requirements\n", $2 
        }
    }     
    END{}' usrpwords.txt # From file named usrpwords.txt

# Exit script if no errors occurred 
exit 0
