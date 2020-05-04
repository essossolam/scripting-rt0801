#!/usr/local/bin/python3 
import re
import subprocess
import csv

cmd1 = "ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 4 > proc"
proc_sup_cpu = subprocess.run(cmd1,stdout=subprocess.PIPE,shell=True)
cmd2 = "ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 4"
proc_sup_mem = subprocess.run(cmd2,stdout=subprocess.PIPE,shell=True)

# for item in (proc_sup_cpu.stdout.decode('utf-8').split()):
#     print(item)

# print(proc_sup_cpu.stdout.decode('utf-8'))
# print(proc_sup_mem.stdout.decode('utf-8'))
