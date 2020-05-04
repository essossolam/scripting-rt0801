#!/bin/bash

username=$(whoami)
user=$(id $username)

echo "Username: $username" 
printf "\n"
echo "UID: $(echo ${user} | cut -d ' ' -f1 | sed -e 's/uid=//' -e 's/\([0-9][0-9]*\).*/\1/')"
printf "\n"
echo "Groupes: $(echo ${user} | cut -d " " -f3 | sed 's/groupes=//')"
