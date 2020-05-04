#!/usr/local/bin/python3
import re
import subprocess
import os
import sys
import csv

SYS_BD = "/home/superv/sys_bd"
DISK_BD = "/home/superv/disk_bd"

html_c2 = "<html><head><meta charset='utf-8'><title>Supervision Machine C2</title></head><body><p><h1>Spervision Machine C2<h1>"
html_c3 = "<html><head><meta charset='utf-8'><title>Supervision Machine C3</title></head><body><p><h1>Spervision Machine C3<h1>"

#Machine C2
html_c2 += "<h2>UPTIME: </h2><table><thead><tr><th>Host</th><th>Uptime</th><th>Load Average</th></tr></thead><tbody>"
with open(SYS_BD+"C2.csv", 'r') as _sys_bd:
    sysreader = csv.reader(_sys_bd, delimiter=';')
    for row in sysreader:
        html_c2 += "<tr><td>{}<td><td>{}<td><td>{}<td></tr>".format(
            row[0], row[1], row[3])
_sys_bd.close
html_c2 += "</tbody></table><br/><h2>DISQUES: </h2><table><tr><th>Disk</th><th>Total</th><th>Used</th><th>Free</th><th>Percentage</th></tr>"

with open(DISK_BD+"C2.csv", 'r') as _disk_bd:
    diskreader = csv.reader(_disk_bd, delimiter=';')
    for row in diskreader:
        html_c2 += "<tr><td>{}<td><td>{}<td><td>{}<td><td>{}<td><td>{}<td></tr>".format(row[1],
         row[2], row[3], row[4], row[5])
_disk_bd.close
html_c2 += "</table><br/><h2>Processeur: </h2><br/><h4>CPU</h4><br/></p></body></html>"

#Machine C3
html_c3 += "<h2>UPTIME: </h2> <table><tr><th>Host</th><th>Uptime</th><th>Load Average</th></tr>"
with open(SYS_BD+"C3.csv", 'r') as _sys_bd:
    sysreader = csv.reader(_sys_bd, delimiter=';')
    for row in sysreader:
        html_c3 += "<tr><td>{}<td><td>{}<td><td>{}<td></tr>".format(
            row[0], row[1], row[3])
_sys_bd.close
html_c3 += "</table><table></thead><tr><th colspan='5'>DISQUES: </th></tr><tr><th>Disk</th><th>Total</th><th>Used</th><th>Free</th><th>Percentage</th></tr></thead><tbody>"

with open(DISK_BD+"C3.csv", 'r') as _disk_bd:
    diskreader = csv.reader(_disk_bd, delimiter=';')
    for row in diskreader:
        html_c3 += "<tr><td>{}<td><td>{}<td><td>{}<td><td>{}<td><td>{}<td></tr>".format(row[1],
         row[2], row[3], row[4], row[5])
_disk_bd.close

html_c3 += "</table><br/><h2>Processeur: </h2><br/><h4>CPU</h4><br/><table>"

_proc_C3 = open("/home/superv/proc_sup_cpuC3")

for line in _proc_C3.readlines():
  html_c3 +="<tr>"
  for row in line.split():
      html_c3 += "<td>{}</td>".format(row)
  html_c3 +="</tr>"
_proc_C3.close()

html_c3 += "</table><br/><h4>Mémoire</h4><br/><table>"

_proc_mem_C3 = open("/home/superv/proc_sup_memC3")

for line in _proc_mem_C3.readlines():
  html_c3 +="<tr>"
  for row in line.split():
      html_c3 += "<td>{}</td>".format(row)
  html_c3 +="</tr>"
_proc_mem_C3.close()

html_c3 +="</table></p></body></html>"
# Sauvegarde du fichier HTML
cmd_save_html2 = "echo '{}' > /var/www/html/machineC2.html".format(html_c2)
cmd_save_html3 = "echo '{}' > /var/www/html/machineC3.html".format(html_c3)
subprocess.run(cmd_save_html2, shell=True)
subprocess.run(cmd_save_html3, shell=True)

# cmd = "echo {} > /home/superv/machine1.html".format(header)
# subprocess.run(cmd, shell=True)
