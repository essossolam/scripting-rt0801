#!/usr/local/bin/python3 
import re
import subprocess
import os
import sys
import time

REMOTE_IP = sys.argv[1]
SYS_BD = "/home/superv/sys_bd"
DISK_BD = "/home/superv/disk_bd"


#HOSTNAME
HOSTNAME = subprocess.run(["ssh","superv@{}".format(REMOTE_IP),"hostname"],stdout=subprocess.PIPE).stdout.decode('utf-8')
# pas de capture de la sortie 
# Il faudra recolter les infos via ssh
uptime = subprocess.run(["ssh","superv@{}".format(REMOTE_IP),"uptime"],stdout=subprocess.PIPE)
match_l = re.search('load(.*)' ,uptime.stdout.decode('utf-8') ,re.IGNORECASE)
match_string = re.compile('up.*user')
match_up_time = match_string.search(uptime.stdout.decode('utf-8') ,re.IGNORECASE)

_average = re.search('load average:(.*)', match_l.group(0), re.IGNORECASE)

#Strip permet d'enlever les espaces et sauts de lignes en début et fin de chaines
load_average = _average.group(1).strip().split(" ")
# print('Load Average:', load_average)
_uptime = match_up_time.group(0).split(",")[0]
_users = match_up_time.group(0).split(",")[1]
# print('Uptime:', match_up_time.group(0).split(",")[0])
# print('Users:', match_up_time.group(0).split(",")[1])

df = subprocess.run(["ssh","superv@{}".format(REMOTE_IP),"df","-H"], stdout=subprocess.PIPE)
match_df = re.compile("tmpfs.*|/dev/.*")
match_disk = match_df.findall(df.stdout.decode('utf-8') ,re.IGNORECASE)

#Process

cmd1 = "ssh superv@{} ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 4 > /home/superv/proc_sup_cpu{}".format(REMOTE_IP, HOSTNAME.strip())
proc_sup_cpu = subprocess.run(cmd1,stdout=subprocess.PIPE,shell=True)
cmd2 = "ssh superv@{} ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 4 > /home/superv/proc_sup_mem{}".format(REMOTE_IP, HOSTNAME.strip())
proc_sup_mem = subprocess.run(cmd2,stdout=subprocess.PIPE,shell=True)

#Sauvegarde UPTIME dans le fichier correspondant
_sys_bd = open( SYS_BD+HOSTNAME.strip()+".csv","w+")
_sys_bd.write('{};{};{};{}\n'.format(HOSTNAME.strip(),_uptime.strip(),_users.strip(),load_average))
_sys_bd.close


#Sauvegarde des disks dans le fichier correpondant
_disk_bd = open( DISK_BD+HOSTNAME.strip()+".csv","w+")
for item in match_disk:
    _disk_bd.write('{};{};{};{};{};{}\n'.format(HOSTNAME.strip(),
    item.split()[0], item.split()[1], item.split()[2], item.split()[3], item.split()[4]))
_disk_bd.close





