#!/bin/bash
 
HOSTNAME=$1
NIC=$2
IPADDR=$3
GATEWAY=$4
DNS=$5

if [ $# -eq 5 ]
then
  echo $HOSTNAME > /etc/hostname
  systemctl restart systemd-logind.service
  #if [ $NIC == ""  ]
else
 echo "Nombre de paremetre invalide!!!"
fi