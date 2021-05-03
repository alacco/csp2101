# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initialise and populate the attackTypes array to be used within the script
attackTypes=("DDOS" "MALWARE" "XSS" "SQL-INJ" "MitM")

# Display main headings
echo -e "Attacks\t\tInstances(Q3)"

# Iterate through each attack type stored in the attackTypesArray
for i in ${!attackTypes[@]}; 
do
    # Search for any referance to the attack type listed at the 
    # current iteration of the array within the attacks.html file
    # and then pipe the results to sed command
    grep -iw "${attackTypes[$i]}" attacks.html |            
    # Remove all <td>,<tr> and </tr> tags and replace all </td> 
    # tags with a comma and then pipe the results to awk command
    sed -e 's/<t[d,r]>//g; s/<\/td>/,/g; s/<\/tr>//g' |     
    # Display the attack name total number of attacks
    awk 'BEGIN {FS=","}
        { printf "%-15s %d\n", $1, $2+$3+$4 }
        END{}'
done

# Exit script if no errors occurred 
exit 0