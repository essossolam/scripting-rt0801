#!/bin/bash

BACKUP_SERVER="192.168.1.10" 
REP="/home/superv/sync_dir"
REMOTE_REP="/home/superv/sauvegarde/$(hostname)"
 
declare -a fichiers=("/home/superv/sync_dir/c2" "/home/superv/sync_dir/c3")

echo -e "===========Début Synchronisation==========\n"

if [ -d $REP ]
then 
    echo -e "-----Directory: $REP"
    touch /home/superv/sync_logs
    echo -e "Date: $(date)\n" >> /home/superv/sync_logs
    echo -e "================================================================ \n" >> /home/superv/sync_logs
    echo -e "Fichier  \t Etat   \t Taille   \t Actions   \t\n" >> /home/superv/sync_logs
    echo -e "================================================================ \n" >> /home/superv/sync_logs
    for file in $(ls $REP)
    do 
       remote=$(ssh superv@$BACKUP_SERVER "stat -c %Y $REMOTE_REP/$file")
       _local=$(stat -c %Y $REP/$file) 

       if [ $_local -gt $remote ]
       then
            file_state="modify"
            scp -r -p $REP/$file superv@$BACKUP_SERVER:$REMOTE_REP
            
            echo "last command output: $?"
       elif [ $_local -eq $remote ]
       then 
            file_state="synchronise"
            file_size=$(stat -c %s $REP/$file)

            echo -e "-----Nothing to do for : $file, It is up to date."
            echo -e "$file  \t\t $file_state   \t $file_size   \t\t Actions   \t\n" >> /home/superv/sync_logs
       else
          echo -e "Your file is corrupted! Please check this..."
       fi
    done
    echo -e "================================================================ \n" >> /home/superv/sync_logs
else
    echo -e "-----Files: $REP"
   
    for file in ${fichiers[*]}
    do
        echo "***$file"
        if [ -e $file ]
        then
           echo  "Ce fichier existe"
        else
           echo "Ce fichier n'existe pas"
        fi
    done 
fi