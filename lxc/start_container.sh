#!/bin/bash

echo "Donner l identifiant du conteneur ou une regex:"
read REGEX

for c in $(lxc-ls | grep "$REGEX*")
do 
    { # try
        lxc-start -n $c
        echo "Le conteneur $c a été bien démarré!!!"
    } || { # catch
        echo "Une erreur s'est produite lors du démarrage du conteneur: $c" 
        exit 1
    }
done

exit 0