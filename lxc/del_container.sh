#!/bin/bash

echo "Donner l identifiant du conteneur ou une regex:"
read REGEX

for c in $(lxc-ls | grep "$REGEX*")
do 
    { # try
        lxc-stop -n $c
        lxc-destroy -n $c
        echo "Le conteneur $c a été bien détruit!!!"
    } || { # catch
        echo "Une erreur s'est produite lors de la destruction du conteneur: $c" 
        exit 1
    }
done

exit 0