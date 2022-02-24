#!/usr/bin/env bash
#
# Script Name: utils.sh
#
# Author: Jordy 
# Date : 12/11/2021
#
# Description: The following script content all functions required in main.sh
#
# Run Information:
#
# Error Log: 
#
SCRIPT_HOME=~/scripting/shell/exercices/solutions/address_book
export ADDRESS_BOOK=$SCRIPT_HOME/.address_book
oldIFS=$IFS
# User confirmation
confirm(){
    echo -en "$@ - (Y/n):"
    read answer
    if [[ $(echo $answer | tr '[a-z]' '[A-Z]') == "Y" ]]; then 
        return 0
    else
        return 1
    fi
}

# Function to display option titles
show_title(){
    echo -en "*********"
    echo -en "$@"
    echo "*********"
}

# Diplay record(s)
display() {
    local lineNbr=0
    local line
    local input
    echo "Found ($#) record(s)."
    IFS=' '
    if [[ $# -gt 0 ]]; then
        for line in $*; do
            let ++lineNbr
            # print line number
            echo -n "${lineNbr}. " 
            IFS=':'
            echo "${line}"
        done
    fi
    IFS=$oldIFS
}

perform_search() {
    echo $(grep "$1" $ADDRESS_BOOK)
}

# Function to make a search in addresss book
search_items() {
    show_title "SEARCH"
    echo -en "Enter your keywords: "
    read key
    display "$(perform_search $key)"
}

select_item() {
    local choice
    local response
    local tmp_file
    # Create a tmp file
    tmp_file=$(mktemp --tmpdir="$SCRIPT_HOME" search.XXXXXXXXX)
    # Fullfil tmp file with user search val
    IFS=' '
    for line in $1; do
        echo "${line}" >> "${tmp_file}"
    done
    IFS=$oldIFS

    # Get the desired line 
    response=$(awk "NR==${2}{ print; exit }" "${tmp_file}")
    # Delete the tmp file created
    rm "${tmp_file}"

    echo "$response"
}

# Function to save item into a file
save_into_file(){
    echo -e "$1\n" >> $ADDRESS_BOOK
}

# Function to parse item data before saved
parse_values() {
    local parsed=""
    local cpt=0
    for i in $*; do
        let ++cpt
        if [[ $# -eq $cpt ]]; then
            parsed+="$i"
        else
            parsed+="$i:"
        fi
    done
    echo $parsed
}
# Function to remove one entry
remove_item() {
    local response
    show_title "SEARCH"
    echo -en "Enter your keywords: "
    read key
    #
    response=$(perform_search "$key")
    display "$response"
    echo -en "Please enter the line number of your desired entry: "
    read choice
    response=$(select_item "${response}" "${choice}")
    display "${response}"
}

edit_item() {
    echo "Edit item..."
}

# Function to add new item in address book
add_item() {
    show_title "NEW ITEM"
    echo -en "Name: "
    read name
    echo -en "Surname: "
    read surname
    echo -en "Email: "
    read email
    echo -en "Phone: "
    read phone

    # Search for duplicate item
    if [[ -n $(perform_search "$name") && -n $(perform_search "$surname") ]]; then
        echo "It appear that the item already exist !"
        confirm "Would do you want to edit the existing item ?"
        if [[ $? -ne 1 ]]; then
            edit_item
        else
            return 0
        fi 
    else    
        confirm "Did you confirm that your inputs are correct ?"
        if [[ $? -ne 0 ]]; then
            add_item
        else
            item=$(parse_values "$name" "$surname" "$email" "$phone")
            save_into_file $item
        fi
    fi 
    
}

# Process menu options
process_menu() {
    case $1 in
        1) search_items ;;
        2) add_item ;;
        3) edit_item ;;
        4) remove_item ;;
        *) echo "Sorry no matching choice" ;;
    esac
}
