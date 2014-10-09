#!/bin/bash
POOL=Tank
BPOOL=BackupPool
LAST=$(zfs list -t snapshot | grep $BPOOL@ | grep daily | tail -n1 | cut -d ' ' -f 1 | cut -d '@' -f 2)
CURRENT=$(zfs list -t snapshot | grep $POOL@ | grep daily | tail -n1 | cut -d ' ' -f 1 | cut -d '@' -f 2)

#Noone should ever write to the backup pool directly. If they did, get rid of it. 
for i in $(zfs list -t snapshot | grep $BPOOL | grep $LAST | cut -d ' ' -f 1 )
do
  zfs rollback -r $i
done

zfs send -Ri "$POOL"@"$LAST" "$POOL"@"$CURRENT" | pv | zfs recv $BPOOL
