#!/bin/bash    

# where the sd card image will be stored
# /mnt/hdd2tb is the mount point for an external HDD
HDD2TBMOUNTPOINT="/mnt/hdd2tb"

# fdisk -l 
# to find the /dev path for the SD Card
SDCARDDEV="/dev/mmcblk0"

TIMENOW=$(/usr/bin/date +"%Y%m%dT%H%M%S")

BKPFILE="bkp/pi3-$TIMENOW.img"

# test if HDD2TBMOUNTPOINT has something mounted into
if /usr/bin/mountpoint -q "$HDD2TBMOUNTPOINT"
then
    /usr/bin/echo "$(/usr/bin/date --iso-8601=seconds) Starting dd bs=4M if=$SDCARDDEV of=$HDD2TBMOUNTPOINT/$BKPFILE:"
    /usr/bin/dd bs=4M if="$SDCARDDEV" of="$HDD2TBMOUNTPOINT/$BKPFILE" status=progress
    /usr/bin/echo "$(/usr//bin/date --iso-8601=seconds) Finished dd bs=4M if=$SDCARDDEV of=$HDD2TBMOUNTPOINT/$BKPFILE."
    /usr/bin/echo "Backup file size: $(ls -lah $HDD2TBMOUNTPOINT/$BKPFILE)"

else
    /usr/bin/echo "$HDD2TBMOUNTPOINT is not a mountpoint"
    /usr/bin/echo "Aborting."
fi

# todo keep only X backup files
#cd 
#find . -name "*.dat" -mtime -2 -print

