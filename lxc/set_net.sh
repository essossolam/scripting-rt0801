#!/bin/bash
#Configuration bridge NAT

ip link add name br type bridge 
ip addr add 192.168.1.1/24 dev br 
ip link set dev br up
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE 