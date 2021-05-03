# CSP2101 - Scripting Languages: Assignment 3 - Software Based Solution
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

command1(){
    awk 'BEGIN {FS=","; RS="\r\n"} NR>1 && $3 ~ /UDP/ && $4 ~ /101/ { printf "| %-8s | %-10s | %-8s | %-10s | %-9s | %-7s | %-5s |\n", $3, $4, $5, $6, $7, $8, $9; }'
} 

command2() {
    #data="$1"
    data2=`echo "$1" | awk -v var="$2" 'BEGIN {FS=","; RS="\r\n"} $3 ~ var { printf "%s\n", $0;  }'`
    
    #echo "$data2" #| awk 'BEGIN {FS=","; RS="\r\n"} $4 ~ /101/ { printf "%s\n", $0;  }'
}

command3() {
    data3=`echo "$data2" | awk 'BEGIN {FS=","} $4 ~ /101/ { printf "| %-8s | %-10s | %-8s | %-10s | %-9s | %-7s | %-5s |\n", $3, $4, $5, $6, $7, $8, $9; }'`
} 


#command2

fileData=`cat serv_acc_log_03042020.csv`


    until [ "$validDirectory" = true ]; do
        read -p "Enter directory to save file: " exportDirectory
        if [ "$exportDirectory" == "" ] ; then
            echo -e "\e[1;31mDirectory name cannot be empty!\e[0m"
            vaildDirectory=false
        else
            if [ ! -e "$exportDirectory" ]; then
                echo -e '\nDirectory does not exist!'
                echo -e "Creating directory $exportDirectory"
                mkdir "$exportDirectory"
            else
                echo '\nDirectory already exist'
            fi
            validDirectory=true
        fi
    done


#cd $exportDirectory
#ls



#data="test"
#echo "+----------+------------+----------+------------+-----------+---------+-------+"
#echo "| PROTOCOL | SRC IP     | SRC PORT | DEST IP    | DEST PORT | PACKETS | BYTES |" 
#echo "+----------+------------+----------+------------+-----------+---------+-------+"
##command1 | command3 #| command3
##cat serv_acc_log_03042020.csv | command2
#command2 "$fileData" GRE
##command3 
#echo "$data2"
#echo "+----------+------------+----------+------------+-----------+---------+-------+"

