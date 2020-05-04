#!/bin/bash

echo "Donner le nom du conteneur:"
read CTN_NAME

echo "---template du conteneur:"
read CTN_TEMPLATE

echo "---addresse réseau du conteneur:"
read CTN_IP

echo "----mémoire du conteneur:"
read CTN_MEMORY

echo "----CPU du conteneur:"
read CTN_CPU

echo "-----Mot de passe root du conteneur:"
read CTN_PWD

{ # try
   lxc-create -t $CTN_TEMPLATE -n $CTN_NAME
   
   #Copie du fichier original de config en cas de problème
   cp /var/lib/lxc/$CTN_NAME/config config.orig

   sed -i "s/lxc.net.0.type = .*/lxc.net.0.type = veth/" /var/lib/lxc/$CTN_NAME/config

   echo "lxc.net.0.link = br" >> /var/lib/lxc/$CTN_NAME/config
   echo "lxc.net.0.flags = up" >> /var/lib/lxc/$CTN_NAME/config
   echo "lxc.net.0.veth.pair = br-$CTN_NAME" >> /var/lib/lxc/$CTN_NAME/config
   echo "lxc.net.0.ipv4.address = $CTN_IP" >> /var/lib/lxc/$CTN_NAME/config
   echo "lxc.net.0.ipv4.gateway = 192.168.1.1" >> /var/lib/lxc/$CTN_NAME/config

   lxc-start -n $CTN_NAME
   lxc-cgroup -n $CTN_NAME cpuset.cpus "0"
   lxc-cgroup -n $CTN_NAME memory.limit_in_bytes $CTN_MEMORY
   #lxc-attach -n $CTN_NAME -- echo root:pwd | $CTN_PWD
   lxc-stop -n $CTN_NAME

} || { # catch
    echo "Une erreur s'est produite lors de la création du conteneur: $CTN_NAME" 
}

exit 0