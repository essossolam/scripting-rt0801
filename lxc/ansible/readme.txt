Installation de Ansible sur DEBIAN

Etape 1: Ajout du depot suivant à /etc/apt/sources.list

deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main

Etape 2:

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

Etape 3:

sudo apt update
sudo apt install ansible


### LXC CONTAINER ###
il est nécessaire d'installer ce package pour travailler avec le module Ansible LXC

apt-get install lxc-dev

