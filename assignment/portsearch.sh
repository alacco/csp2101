# CSP2101 - Scripting Languages: Assignment 3 - Software Based Solution
# Student: Adam Lacco    ID: 10430272

#!/bin/bash
awk 'BEGIN {FS=","}
NR>1 { 
    sub("\r$", "");
    if (match($4,/SER*/))      
    {
        printf "%s\n", $0; 
    } 
}     
END{}' serv_acc_log_03042020.csv