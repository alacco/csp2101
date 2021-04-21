# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

attackTypes=("DDOS" "MALWARE" "XSS" "SQL-INJ" "MitM")

echo -e "Attacks\t\tInstances(Q3)"
for i in ${!attackTypes[@]}; 
do
    grep -iw "${attackTypes[$i]}" attacks.html | 
    sed -e 's/<t[d,r]>//g; s/<\/td>/,/g; s/<\/tr>//g' |
    awk 'BEGIN {FS=","}
        { printf "%-15s %d\n", $1, $2+$3+$4 }
        END{}'
done



exit 0