#!/bin/bash

echo "Donner l identifiant du conteneur ou une regex:"
read REGEX

for c in $(lxc-ls | grep "$REGEX*")
do 
    { # try
        lxc-stop -n $c
        echo "Le conteneur $c a bien été  stoppé!!!"
    } || { # catch
        echo "Une erreur s'est produite lors de l extinction du conteneur: $c" 
        exit 1
    }
done

exit 0