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

#Utils function script location
source ~/scripting/shell/exercices/solutions/address_book/utils.sh

main(){
    echo -en "******"
    echo -en "ADDRESS BOOK MENU"
    echo "******"
    echo "1. Search address book"
    echo "2. Add entries"
    echo "3. Remove / edit entries"
    echo -en "Enter your choice: "
    read choice
    #Call process_menu with user choice
    process_menu $choice

    exit 0
}


main "$@"