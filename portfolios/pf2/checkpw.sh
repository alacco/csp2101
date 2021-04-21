# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

awk 'BEGIN {FS="\t"}
    NR>1 { 
        sub("\r$", "");
        if (length($2)>=8 && match($2,/[A-Z]/) && match($2,/[0-9]/))      # Check if password is 8 or more characters in length
        {
            printf "%s - meets password strength requirements\n", $2 
        #    validPassword=1       # Set to 1 if true
        } else {
            printf "%s - does NOT meet password strength requirements\n", $2 
            #validPassword=0       # set to 0 if false
        }

    }     
    END{}' usrpwords.txt

exit 0
