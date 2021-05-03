# CSP2101 - Scripting Languages: Assignment 2.2 - Portfolio Task 2
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initialise and populate the two arrays to be used within the script
ass1=(12 18 20 10 12 16 15 19 8 11)
ass2=(22 29 30 20 18 24 25 26 29 30)

# Iterate through each item within the arrays
for (( i=0; i<=${#ass1[@]}-1; i++)); do
    # Add the values held at the current loop iteration of both arrays together and store as finalScore
    finalScore=$((${ass1[$i]}+${ass2[$i]}))
    # Display the student and results from the current loop iteration
    printf "Student_%-2d Result: %d\n" "$(($i+1))" "$finalScore"
done

# Exit script if no errors occurred 
exit 0

