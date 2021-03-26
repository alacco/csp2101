# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

valid_match_menu_input=false
valid_search_menu_input=false

read -p 'Enter the pattern you want to search for: ' pattern

until [ "$valid_match_menu_input" = true ]; do
    echo -e "Do you want search each line for ($pattern):"
    echo -e '(1) As a whole word.'
    echo -e '(2) As a partial word.'
    read -p 'Enter 1 or 2: ' user_selection_match
    if [ $user_selection_match = 1 ]; then
        echo -e "\nSearching for '$pattern' as a whole word.\n"
        valid_match_menu_input=true
    elif [ $user_selection_match = 2 ]; then
        echo -e "\nSearching for '$pattern' as a partial word.\n"
        valid_match_menu_input=true
    else
        echo -e '\nInvalid input\n'
    fi
done

until [ "$valid_search_menu_input" = true ]; do
    echo -e 'Do you want to:'
    echo -e "(1) Search for lines containing '$pattern'"
    echo -e "(2) Search for lines not containing '$pattern'"
    read -p 'Enter 1 or 2: ' user_selection_search
    if [ $user_selection_search = 1 ]; then
        echo -e "\nSearching for lines containing '$pattern'.\n"
        valid_search_menu_input=true
    elif [ $user_selection_search = 2 ]; then
        echo -e "\nSearching for line not containing '$pattern'.\n"
        valid_search_menu_input=true
    else
        echo -e '\nInvalid input\n'
    fi
done


if [[ $user_selection_match = 1 && $user_selection_search = 1 ]]; then
    search_results=$(grep -iwn "$pattern" access_log.txt)
    if [[ ! -z $search_results ]]; then
        number_of_matches=$(echo "$search_results" | wc -l)
        echo -e"$number_of_matches matches found\n"
                echo "$search_results"
    else
        echo -e "No matches found\n"
    fi 
elif [[ $user_selection_match = 2 && $user_selection_search = 1 ]]; then
    search_results=$(grep -in "$pattern*" access_log.txt)
    if [[ ! -z $search_results ]]; then
        number_of_matches=$(echo "$search_results" | wc -l)
        echo -e "$number_of_matches matches found\n"
                echo "$search_results"
    else
        echo "No matches found"
    fi
elif [[ $user_selection_match = 1 || $user_selection_match = 2 && $user_selection_search = 2 ]]; then
    search_results=$(grep -ivn "$pattern*" access_log.txt)
    if [[ ! -z $search_results ]]; then
        number_of_matches=$(echo "$search_results" | wc -l)
        echo -e "$number_of_matches matches found\n"
                echo "$search_results"
    else
        echo "No matches found"
    fi
else
    echo "Invaild selection."
fi

exit 0