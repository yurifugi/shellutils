#!/usr/bin/env bash

#set -x 

SOURCES_LIST=("ifconfig.me/ip" "icanhazip.com")
LOGFILE="$HOME/Desktop/logs/myip.out"
TIMESTAMP=$(date +"%Y-%m-%d-%H:%M")

# echo "TIMESTAMP=$TIMESTAMP"
# echo "MY_IP=$MY_IP."

for SOURCE in "${SOURCES_LIST[@]}"
do
    MY_IP=$(curl -s -4 "${SOURCE}")
    # echo "SOURCE=$SOURCE"
    # echo "MY_IP=$MY_IP"
    if [[ $MY_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
    then
        # echo "Writing $TIMESTAMP $MY_IP to $LOGFILE"
        echo "$TIMESTAMP $MY_IP" #>> "$LOGFILE"
        exit 1
    fi
done
