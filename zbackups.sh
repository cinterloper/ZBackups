#!/bin/bash
SRC="TI"
DST="NUCBackup"












zfs list -t snapshot | grep $(date +"%Y-%m-%d") | grep $SRC | grep daily | cut -d ' ' -f 1 > next.bklst
