#!/bin/bash

scp -r -p sonde_sys.py superv@192.168.1.10:/home/superv
scp -r -p generate_html.py superv@192.168.1.10:/home/superv
lxc-attach -n C1 -- python3.7 /home/superv/sonde_sys.py 192.168.1.11
lxc-attach -n C1 -- python3.7 /home/superv/sonde_sys.py 192.168.1.12
lxc-attach -n C1 -- python3.7 /home/superv/generate_html.py

#pour acceder à la page web à distante 
#iptables -t nat -A PREROUTING -p tcp -i enp0s3 --dport 8080 -j DNAT --to-destination 192.168.1.10:80