#!/bin/bash

#Transfert du script de tranfert vers C1 dans C2
scp -r -p ajout_rep.sh superv@192.168.1.11:/home/superv
scp -r -p sync.sh superv@192.168.1.11:/home/superv
lxc-attach -n C2 --  chmod +x /home/superv/ajout_rep.sh
lxc-attach -n C2 --  chmod +x /home/superv/sync.sh
#lxc-attach -n C2 --  ./home/superv/ajout_rep.sh
lxc-attach -n C2 --  ./home/superv/sync.sh

#Transfert du script de tranfert vers C1 dans C3
scp -r -p ajout_rep.sh superv@192.168.1.12:/home/superv
scp -r -p sync.sh superv@192.168.1.12:/home/superv
lxc-attach -n C3 --  chmod +x /home/superv/ajout_rep.sh
lxc-attach -n C3 --  chmod +x /home/superv/sync.sh
#lxc-attach -n C3 --  ./home/superv/ajout_rep.sh
lxc-attach -n C3 --  ./home/superv/sync.sh