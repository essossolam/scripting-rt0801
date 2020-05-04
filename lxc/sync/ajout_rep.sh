#!/bin/bash

BACKUP_SERVER="192.168.1.10" 
REP="/home/superv/sync_dir"
REMOTE_REP="/home/superv/sauvegarde/$(hostname)"
# if ssh superv@$BACKUP_SERVER [ -d $REMOTE_REP ]
# then 
#    echo "Directory exist"
#    exit 
# else 
#    echo "Directory not exist"
# fi
scp -r -p $REP superv@$BACKUP_SERVER:$REMOTE_REP
#rsync -az $REP superv@$BACKUP_SERVER:$REMOTE_REP