#!/usr/bin/env bash
#
# Script Name: main.sh
#
# Author: Jordy 
# Date : 12/11/2021
#
# Description: The following script has utilities function in ./utils/sh
#
# Run Information:
#
# Error Log: 
#

set -e

# Utils function script location
UTILS=~/scripting/shell/exercices/solutions/address_book/utils.sh
. "${UTILS}"

# [TODO]
# Function to print usage of this script
usage(){
    echo "On progress..."
}

main(){
    # Show menu title
    show_title "ADDRESS BOOK MENU"
    echo "1. Search address book"
    echo "2. Add entry"
    echo "3. Edit entry"
    echo "4. Remove entry"
    echo -en "Enter your choice: "
    read -r choice
    # Call process_menu with user choice
    process_menu "$choice"

    exit 0
}


main "$@"