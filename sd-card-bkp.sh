#!/bin/bash    

/usr/bin/logger -p local0.notice -t sd-card-bkp Starting sd-card-bkp.sh

TIMENOW=$(/usr/bin/date +"%Y%m%dT%H%M%S")

# where the sd card image will be stored
# /mnt/hdd2tb is the mount point for an external HDD
HDD_FOLDER="/mnt/sda1"
BKP_FOLDER="bkp"
BKP_FILE="$(hostname)-${TIMENOW}.img.gz"

# fdisk -l 
# to find the /dev path for the SD Card
SD_DEV="/dev/mmcblk0"

# test if HDD2TBMOUNTPOINT has something mounted into
if /usr/bin/mountpoint -q "$HDD_FOLDER"
then
    /usr/bin/logger -p local0.notice -t sd-card-bkp Starting sd-card-bkp.sh

    /usr/bin/dd bs=4M \
        if="$SD_DEV" \
        | /usr/bin/gzip -9 "$HDD_FOLDER/$BKP_FOLDER/$BKP_FILE" 2>&1 \
        | /usr/bin/logger -p local0.notice -t sd-card-bkp

    /usr/bin/logger -p local0.notice -t sd-card-bkp Finished sd-card-bkp.sh

#    /usr/bin/find "$HDD_FOLDER/$BKP_FOLDER/" -type f -mtime +3

else
    /usr/bin/logger -p local0.notice -t sd-card-bkp Aborted because no HDD is mounted
fi

# todo keep only X backup files
#cd 
#find . -name "*.dat" -mtime -2 -print

