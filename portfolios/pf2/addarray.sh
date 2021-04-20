# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initialise the two arrays to be used within the script
ass1=(12 18 20 10 12 16 15 19 8 11)
ass2=(22 29 30 20 18 24 25 26 29 30)

for (( i=0; i<=${#ass1[@]}-1; i++)); do
    finalScore=$((${ass1[$i]}+${ass2[$i]}))
    echo -e "Student_$(($i+1)) Result:\t$finalScore"
done

exit 0

