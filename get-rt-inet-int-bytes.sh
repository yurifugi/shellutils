#!/usr/bin/env bash

echo $(date --iso-8601=seconds;\
    sshpass \
        -p "$1" ssh \
        -o StrictHostKeyChecking=no \
        admin@10.1.1.1 \
        ip -s link show vlan1  | \
        grep -v bytes | \
        sed -n 3,4p | \
        sed 's/^[ \t]*//' | \
        cut -d" " -f1 | \
        xargs) >> /mnt/sda1/stats/router-internet.csv
