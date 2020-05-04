#!/bin/bash

apt-get install lxc lxc-templates -y bridge-utils




# #Array declaration 
# declare -a LIST_CTN
# for  n in $(seq 1 $NBR_CONTAINER)
# do 
#     echo "Donner le nom du conteneur $n:"
#     read CTN_NAME

#     { # try
#     #lxc-create -t debian -n $CTN_NAME
#     LIST_CTN[$n-1]=$CTN_NAME
#     } || { # catch
#       echo "Une erreur s'est produite lors de la création du conteneur: $n" 
#     }
# done

# #Création du bridge 
# echo ${LIST_CTN[*]}
