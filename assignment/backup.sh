# CSP2101 - Scripting Languages: Assignment 3 - Software Based Solution
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

validateMenuSelection() {
    if [[ $1 =~ ^[1-$2]$ ]]; then
        validMenuInput=true
    else
        validMenuInput=false
        echo -e '\nInvalid input'
    fi
}

echo '================================================'
echo 'Welcome to the Linux admin log analysis utility.'
echo '================================================'

until [ "$validMenuInput" = true ]; do
    echo -e '\n=================================='
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
    selectedField1=0
    until [ "$validMenuInput" = true ]; do
        echo -e '\n==================================='
        echo -e "      Field $i search columns"
        echo -e '===================================\n'
        echo -e 'Select from the following options:\n'
#        echo -e "(1) PROTOCOL"
#        echo -e "(2) SRC IP"
#        echo -e "(3) SRC PORT"
#        echo -e "(4) DEST IP"
#        echo -e "(5) DEST PORT"
#        echo -e "(6) PACKETS"
#        echo -e "(7) BYTES"
#        echo -e "(8) CLASS\n"
        IFS=""
        for ((j=0; j<=${#fieldListArray[@]}-1; j++)); do
            echo -e "($(($j+1))) ${fieldListArray[$j]}"
        done
        echo ""
        read -p 'Enter [1-8]: ' searchColumnMenuSelection

        validateMenuSelection $searchColumnMenuSelection 8
    
        case $searchColumnMenuSelection in
            1) selectedField='PROTOCOL';;
            2) selectedField='SRC IP';;
            3) selectedField='SRC PORT';;
            4) selectedField='DEST IP';;
            5) selectedField='DEST PORT';;
            6) selectedField='PACKETS';;
            7) selectedField='BYTES';;
            8) selectedField='CLASS';;
        esac

        case $i in
            1) firstField=$selectedField;;
            2) if [ $selectedField == $firstField ]; then
                    validMenuInput=false
                    echo -e '\nField already selected for search'  
                else
                    secondField=$selectedField
                fi
                ;;
            3) if [ $selectedField == $firstField ]; then
                    validMenuInput=false
                    echo -e '\nField already selected for search'  
                elif [ $selectedField == $secondField ]; then
                    validMenuInput=false
                    echo -e '\nField already selected for search'  
                else
                    thirdField=$selectedField
                fi
                ;;
        esac

    done
    
 
    
done

    echo $firstField
    echo $secondField
    echo $thirdField

exit 0
