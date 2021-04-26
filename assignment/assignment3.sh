# CSP2101 - Scripting Languages: Assignment 3 - Software Based Solution
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

validateMenuSelection() {
    if [[ $1 =~ ^[1-$2]$ ]]; then
        validMenuInput=true
    else
        validMenuInput=false
        echo -e "\n\e[1;31mInvalid input\e[0m"
    fi
}

echo '================================================'
echo 'Welcome to the Linux admin log analysis utility.'
echo '================================================'

until [ "$validMenuInput" = true ]; do
    echo -e '\n==================================='
    echo -e '             Main Menu              '
    echo -e '===================================\n'
    echo -e 'Select from the following options:\n'
    echo -e '(1) Search log file/s'
    echo -e '(2) Exit utility\n'
    read -p 'Enter 1 or 2: ' mainMenuSelection

    validateMenuSelection $mainMenuSelection 2  
done

validMenuInput=false # Set vaildMenuInput back to false

if [ $mainMenuSelection = 1 ]; then
    until [ "$validMenuInput" = true ]; do
        echo -e '\n==================================='
        echo -e '  Number of Fields to Search Menu  '
        echo -e '===================================\n'
        echo -e 'Select from the following options:\n'
        echo -e '(1) Search using One field criteria'
        echo -e '(2) Search using Two field criterias'
        echo -e '(3) Search using Three field criterias\n'
        read -p 'Enter 1, 2 or 3: ' fieldMenuSelection

        validateMenuSelection $fieldMenuSelection 3
    done
else
    exit 0
fi
fieldListArray=("PROTOCOL" "SRC IP" "SRC PORT" "DEST IP" "DEST PORT" "PACKETS" "BYTES" "CLASS")

for (( i=1; i<=$fieldMenuSelection; i++)); do
    validMenuInput=false # Set vaildMenuInput back to false
    
    until [ "$validMenuInput" = true ]; do
        echo -e '\n==================================='
        echo -e "      Field $i search columns"
        echo -e '===================================\n'
        echo -e 'Select from the following options:\n'

        IFS=""
        for ((j=0; j<=${#fieldListArray[@]}-1; j++)); do
            echo -e "($(($j+1))) ${fieldListArray[$j]}"
        done
        echo ""
        read -p 'Enter [1-8]: ' searchColumnMenuSelection

        validateMenuSelection $searchColumnMenuSelection 8
    done
    # backup field info
    #selectedFieldsArray=( "${selectedFieldsArray[@]}" "${fieldListArray[(($searchColumnMenuSelection-1))]}" )
    
    declare -A searchDetailsArray
    
    searchDetailsArray[field$i]="${fieldListArray[(($searchColumnMenuSelection-1))]}"
    read -p 'Enater search pattern: ' searchDetailsArray[search$i]
    echo

    #read -p 
# Keep if array dont work
#    if [ $i = 1 ]; then
#        firstField=${fieldListArray[(($searchColumnMenuSelection-1))]}
#        
#    elif [ $i = 2 ]; then
#        secondField=${fieldListArray[(($searchColumnMenuSelection-1))]}
#    elif [ $i = 3 ]; then
#        thirdField=${fieldListArray[(($searchColumnMenuSelection-1))]}
#        
#    fi

    # remove previously selected fields from array
    fieldListArray=( "${fieldListArray[@]:0:$(($searchColumnMenuSelection-1))}" "${fieldListArray[@]:$searchColumnMenuSelection}" )
   
done
# remove after testing
echo ${searchDetailsArray[field1]} ${searchDetailsArray[search1]}
echo ${searchDetailsArray[field2]} ${searchDetailsArray[search2]}
echo ${searchDetailsArray[field3]} ${searchDetailsArray[search3]}

validMenuInput=false # Set vaildMenuInput back to false
until [ "$validMenuInput" = true ]; do
    echo -e '\n==================================='
    echo -e "   Select server access log menu    "
    echo -e '===================================\n'
    echo -e 'Select from the following options:\n'
    echo -e '(1) Search one server access log'
    echo -e '(2) Search all server access logs\n'
    read -p 'Enter 1 or 2: ' selectAccessLogMenuSelection

    validateMenuSelection $selectAccessLogMenuSelection 2

done


IFS='
'
accessLogFilenameArray=($(ls *.csv))

if [ $selectAccessLogMenuSelection = 1 ]; then
    validMenuInput=false # Set vaildMenuInput back to false
    until [ "$validMenuInput" = true ]; do
        echo -e '\nSelect which log file to search:\n'
        for ((j=0; j<=${#accessLogFilenameArray[@]}-1; j++)); do
            echo -e "($(($j+1))) ${accessLogFilenameArray[$j]}"
        done
        echo ''
        read -p "Enter [1-${#accessLogFilenameArray[@]}]: " selectedAccessLogMenuSelection
        validateMenuSelection $selectedAccessLogMenuSelection ${#accessLogFilenameArray[@]}
    done

    accessLogSelected=${accessLogFilenameArray[$(($selectedAccessLogMenuSelection-1))]}

    echo -e "\nSearching $accessLogSelected access log file\n"
else
    echo -e "\nSearching all access log files\n"
fi

exit 0
