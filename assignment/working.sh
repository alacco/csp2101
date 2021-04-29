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

validateNumberInput() {
    if [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
        validNumber=true
    else
        validNumber=false
        echo -e "\n\e[1;31mInvalid number\e[0m"    
    fi
}

searchFunction() {
    case ${searchDetailsArray[field$(($1))]} in
        'PROTOCOL') echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","; RS"\r\n"} $3 ~ searchData { printf "%s\n", $0; }';;
          'SRC IP') echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $4 ~ toupper(searchData) { printf "%s\n", $0; }';; 
        'SRC PORT') echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $5 == searchData { printf "%s\n", $0; }';;
         'DEST IP') echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $6 ~ toupper(searchData) { printf "%s\n", $0; }';;
       'DEST PORT') echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $7 == searchData && $13 != "normal" { printf "%s\n", $0; }';;
         'PACKETS') if [[ ${searchDetailsArray[operator$(($1))]} = '-eq' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $8 == searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-gt' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $8 > searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-lt' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $8 < searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-!eq' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $8 != searchData { printf "%s\n", $0; }'
                    fi;;
           'BYTES') if [[ ${searchDetailsArray[operator$(($1))]} = '-eq' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $9 == searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-gt' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $9 > searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-lt' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $9 < searchData { printf "%s\n", $0; }'
                    elif [[ ${searchDetailsArray[operator$(($1))]} = '-!eq' ]]; then
                        echo "$2" | awk -v searchData=${searchDetailsArray[search$(($1))]} 'BEGIN {FS=","} $9 != searchData { printf "%s\n", $0; }'
                    fi;;
    esac
}

outputResults() {
        echo "+----------+---------------+----------+---------------+-----------+---------+-------+"
        echo "| PROTOCOL | SRC IP        | SRC PORT | DEST IP       | DEST PORT | PACKETS | BYTES |" 
        echo "+----------+---------------+----------+---------------+-----------+---------+-------+"
        echo "$searchResult" | awk 'BEGIN {FS=","; RS"\n"} { printf "| %-8s | %-13s | %-8s | %-13s | %-9s | %-7s | %-5s |\n", $3, $4, $5, $6, $7, $8, $9; }'
        echo "+----------+---------------+----------+---------------+-----------+---------+-------+"
}


echo '================================================'
echo 'Welcome to the Linux admin log analysis utility.'
echo '================================================'
until [ "$validMenuInput" = true ]; do
    numberOfFieldsSelected=0
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
    portocolArray=("TCP" "UDP" "ICMP" "GRE")

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

        # Set field coloumn of searchDetails Array
        searchDetailsArray[field$i]="${fieldListArray[(($searchColumnMenuSelection-1))]}"


        if [[ ${searchDetailsArray[field$(($i))]} = "PROTOCOL" ]]; then
            validMenuInput=false # Set vaildMenuInput back to false
            until [ "$validMenuInput" = true ]; do
                echo -e '\nWhich protocol are you searching for:\n'

                IFS=""
                for ((j=0; j<=${#portocolArray[@]}-1; j++)); do
                    echo -e "($(($j+1))) ${portocolArray[$j]}"
                done
                echo ""
                read -p 'Enter [1-4]: ' protocolMenuSelection

                validateMenuSelection $protocolMenuSelection 4
            done

            case $protocolMenuSelection in
                1) searchDetailsArray[search$i]="TCP";;
                2) searchDetailsArray[search$i]="UDP";;
                3) searchDetailsArray[search$i]="ICMP";;
                4) searchDetailsArray[search$i]="GRE";;
            esac
        elif [[ ${searchDetailsArray[field$(($i))]} = "PACKETS" || ${searchDetailsArray[field$(($i))]} = "BYTES" ]]; then
            until [ "$validNumber" = true ]; do
            echo ""
                read -p 'Enter search value in bytes: ' searchDetailsArray[search$i]
                validateNumberInput ${searchDetailsArray[search$(($i))]}
            done
            #read -p 'Enter search pattern: ' searchDetailsArray[search$i]
            validMenuInput=false # Set vaildMenuInput back to false
            until [ "$validMenuInput" = true ]; do
                echo -e '\nSearch for records which are:\n'
                echo -e "(1) Greater then ${searchDetailsArray[search$(($i))]}"
                echo -e "(2) Less then ${searchDetailsArray[search$(($i))]}"
                echo -e "(3) Equal to ${searchDetailsArray[search$(($i))]}"
                echo -e "(4) Not equal ${searchDetailsArray[search$(($i))]}"
                read -p 'Enter [1-4]: ' byteOperatorMenuSelection

                validateMenuSelection $byteOperatorMenuSelection 4
            done
            case $byteOperatorMenuSelection in
                1) searchDetailsArray[operator$i]="-gt";;
                2) searchDetailsArray[operator$i]="-lt";;
                3) searchDetailsArray[operator$i]="-eq";;
                4) searchDetailsArray[operator$i]="-!eq";;
            esac
        else  
            read -p 'Enter search pattern: ' searchDetailsArray[search$i]
        fi
        # remove previously selected fields from array
        fieldListArray=( "${fieldListArray[@]:0:$(($searchColumnMenuSelection-1))}" "${fieldListArray[@]:$searchColumnMenuSelection}" )
        numberOfFieldsSelected=$i #$(($numberOfFieldsSelected+1))
    done

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

    # display which logs files to check
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
        fileData=`cat $accessLogSelected | awk 'BEGIN {FS=","} $13 !~ "normal" { printf "%s\n", $0; }'`
        echo -e "\nSearching $accessLogSelected access log file\n"
    else
        for ((j=0; j<=${#accessLogFilenameArray[@]}-1; j++)); do
            fileData+=`cat ${accessLogFilenameArray[$j]}`
        done
        echo -e "\nSearching all access log files\n"
    fi
    validMenuInput=false # Set vaildMenuInput back to false

    
    if [ $numberOfFieldsSelected = 1 ]; then
        #searchFunction 1 "$fileData"
        firstFieldSearch=$(searchFunction 1 "$fileData")
        searchResult="$firstFieldSearch"
    elif [ $numberOfFieldsSelected = 2 ]; then
        firstFieldSearch=$(searchFunction 1 "$fileData")
        secondFieldSearch=$(searchFunction 2 "$firstFieldSearch")
        searchResult="$secondFieldSearch"
    elif [ $numberOfFieldsSelected = 3 ]; then
        firstFieldSearch=$(searchFunction 1 "$fileData")
        secondFieldSearch=$(searchFunction 2 "$firstFieldSearch")
        thirdFieldSearch=$(searchFunction 3 "$secondFieldSearch")
        searchResult="$thirdFieldSearch"
    fi

    if [ "$searchResult" != "" ]; then
        outputResults
        echo ""
        read -p "Enter filename to export search: " exportFilename
        read -p "Enter directory to save file: " exportDirectory
        
        if [ ! -e "$exportDirectory" ]; then
            echo -e '\nDirectory does not exist!'
            echo -e "Creating directory $exportDirectory"
            mkdir "$exportDirectory"
        else
            echo '\nDirectory already exist'
        fi
        
        echo -e '\nExporting to $exportFilename'
        cd $exportDirectory
        outputResults > $exportFilename
    else
        echo -e "\e[1;31mNo matching data found\e[0m"
    fi
done
exit 0
