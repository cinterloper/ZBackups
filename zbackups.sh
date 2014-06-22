#!/bin/bash
SRC="TI"
DST="NUCBackup"
INC="daily"


if [ -e last.bklst ]
 then
	for i in $(cat next.bklst)
	do
		zfs send $i | pv | zfs recv $DST\@$(echo $i | cut -d '@' -f2)
	done






mv next.bklst last.bklst
zfs list -t snapshot | grep $(date +"%Y-%m-%d") | grep $SRC | grep $INC | cut -d ' ' -f 1 > next.bklst
