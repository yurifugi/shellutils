#!/usr/bin/env bash


penDev="/dev/sdb1"
mountPoint="/mnt/pen"


( set -x ; sudo mount "$penDev" "$mountPoint" )

if mountpoint -q "$mountPoint" 
then
   :
else
   echo "$mountPoint is not mounted. Aborting."
   exit 1
fi

cd "$mountPoint"
echo "Folder is" "$(pwd)"
echo "Contents:"
ls --indicator-style=slash --size --human-readable
df -k --human-readable |grep "$mountPoint" | awk '{printf("\n%s in %s capacity: %s. Free:  %s.\n", $1, $6, $2, $4) }'
$SHELL
