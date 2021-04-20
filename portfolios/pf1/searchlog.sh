# CSP2101 - Scripting Languages: Assignment 2.1 - Portfolio Task 1
# Student: Adam Lacco    ID: 10430272

#!/bin/bash

# Initailise variable to be used in the main control loop and set to false
end_script=false

# Begin main script loop until user chooses to exit script
until [ "$end_script" = true ]; do
    # Initialise variables to be used the control variables for the menu loops
    # and set their values to false 
    valid_match_menu_input=false
    valid_search_menu_input=false
    vaild_search_again_input=false
    
    # Ask the user to input what they wish to search for and store result 
    read -p 'Enter the pattern you want to search for: ' pattern

    # Enter the search for word type menu loop until the user enters valid input
    until [ "$valid_match_menu_input" = true ]; do
        # Display options for word search to the user
        echo -e "\nDo you want search each line for ($pattern):"
        echo -e '(1) As a whole word.'
        echo -e '(2) As a partial word.'

        # Ask the user to input which option they want and store result in a variable
        read -p 'Enter 1 or 2: ' user_selection_match

        # Check to see which option the user selected and if the input was valid
        if [ $user_selection_match = 1 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop
            echo -e "\nSearching for '$pattern' as a whole word.\n"
            valid_match_menu_input=true
        elif [ $user_selection_match = 2 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop
            echo -e "\nSearching for '$pattern' as a partial word.\n"
            valid_match_menu_input=true
        else
            # Display message informing user their input was invalid and restart loop
            echo -e '\nInvalid input\n'
        fi
    done

    # Enter the search for lines containing menu loop until the user enters valid input
    until [ "$valid_search_menu_input" = true ]; do
        # Display options for line search to the user
        echo -e 'Do you want to:'
        echo -e "(1) Search for lines containing '$pattern'"
        echo -e "(2) Search for lines not containing '$pattern'"

        # Ask the user to input which option they want and store result in a variable
        read -p 'Enter 1 or 2: ' user_selection_search

        # Check to see which option the user selected and if the input was valid
        if [ $user_selection_search = 1 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop
            echo -e "\nSearching for lines containing '$pattern'.\n"
            valid_search_menu_input=true
        elif [ $user_selection_search = 2 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop  
            echo -e "\nSearching for lines not containing '$pattern'.\n"
            valid_search_menu_input=true
        else
            # Display message informing user their input was invalid and restart loop
            echo -e '\nInvalid input\n'
        fi
    done

    # Check if the user wants to search each line for the whole word 
    if [[ $user_selection_match = 1 && $user_selection_search = 1 ]]; then
        # Search for users word in line within the access_log.txt file and store results
        search_results=$(grep -iwn "$pattern" access_log.txt)
        # Check if search found any results
        if [[ ! -z $search_results ]]; then
            # Count the number of results found, display a message with how many results 
            # found and display those results
            number_of_matches=$(echo "$search_results" | wc -l)
            echo -e "$number_of_matches matches found\n"
                    echo "$search_results"
        else
            # Display no matches found message if none were found
            echo -e "No matches found"
        fi 
    # Check if user want to search each line for a partial word
    elif [[ $user_selection_match = 2 && $user_selection_search = 1 ]]; then
        # Search for users partial word in each line within the access_log.txt file and store results
            search_results=$(grep -in "$pattern+*" access_log.txt)
        # Check if search found any results
        if [[ ! -z $search_results ]]; then
            # Count the number of results found, display a message with how many results 
            # found and display those results
            number_of_matches=$(echo "$search_results" | wc -l)
            echo -e "$number_of_matches matches found\n"
                    echo "$search_results"
        else
            # Display no matches found message if none were found
            echo "No matches found"
        fi
    # Check if user want to search for the lines which do not contain the partial or whole word    
    elif [[ $user_selection_match = 1 || $user_selection_match = 2 && $user_selection_search = 2 ]]; then
        # Search for each line within the access_log.txt file that does not contain 
        # the users partial or whole word and store results
        search_results=$(grep -ivn "$pattern+*" access_log.txt)
        # Check if search found any results
        if [[ ! -z $search_results ]]; then
            # Count the number of results found, display a message with how many results 
            # found and display those results
            number_of_matches=$(echo "$search_results" | wc -l)
            echo -e "$number_of_matches matches found\n"
                    echo "$search_results"
        else
            # Display no matches found message if none were found
            echo "No matches found"
        fi
    fi

    # Enter the search again menu loop until the user enters valid input
    until [ "$vaild_search_again_input" = true ]; do
        # Ask the user if they wish to search again
        echo -e '\nDo you want to search again?'
        echo -e '(1) Search again'
        echo -e '(2) Search to exit application'

        # Ask the user to input which option they want and store result in a variable
        read -p 'Enter 1 or 2: ' search_again_input

        # Check to see which option the user selected and if the input was valid
        if [ $search_again_input = 1 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop
            echo -e "\nRestarting application.\n"
            vaild_search_again_input=true
            user_selection_match=0
            user_selection_search=0
            pattern=""
        elif [ $search_again_input = 2 ]; then
            # Display message listing the option chosen and set valid input to true
            # ending the loop and ending the script  
            echo -e "\nExiting Application\n"
            vaild_search_again_input=true
            end_script=true
        else
            # Display message informing user their input was invalid and restart loop
            echo -e '\nInvalid input\n'
        fi
    done

done

# Exit script if no errors occurred 
exit 0
