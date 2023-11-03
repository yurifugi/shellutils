#!/usr/bin/env bash

# this is a script for using MRTG with Asus RT-AC59U
# mrtg.conf shoud be:
# Title[router_10_1_1_1]: "Title"
# Target[router_10_1_1_1]: `/usr/local/bin/get-rt-inet-int-bytes.sh password` 
# MaxBytes[router_10_1_1_1]: 1073741824

# this script will return the 4 lines at the end of this script


PASSWORD=$1

ROUTER_RETURN=$(sshpass \
        -p "$PASSWORD" ssh \
        -o StrictHostKeyChecking=no \
        "admin@10.1.1.1" \
        'echo -n $(ip -o -s link show vlan1); \
        echo -n "\\ $(cat /proc/uptime)"; \
        echo -n "\\ RT-AC59U"' \
        | tr -s ' ')
        #  | \
        # xargs)"
# echo $ROUTER_RETURN

LINE1=$(echo "$ROUTER_RETURN" | cut -d"\\" -f4)
LINE2=$(echo "$ROUTER_RETURN" | cut -d"\\" -f6)
LINE3=$(echo "$ROUTER_RETURN" | cut -d"\\" -f7)
LINE4=$(echo "$ROUTER_RETURN" | cut -d"\\" -f8)


VAL_INBOUND="$(echo $LINE1 | cut -d' ' -f1)"
VAL_OUTBOUND="$(echo $LINE2 | cut -d' ' -f1)"
VAL_UPTIME="$(echo $LINE3 | cut -d' ' -f1)"
VAL_HOSTNAME="$(echo $LINE4)"

echo "\"$VAL_INBOUND\""
echo "\"$VAL_OUTBOUND\""
echo "\"$VAL_UPTIME\""
echo "\"$VAL_HOSTNAME\""