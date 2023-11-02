#!/usr/bin/env bash

echo -e "$(sshpass \
        -p "39JMjnFKVK4GGt6" ssh \
        -o StrictHostKeyChecking=no \
        admin@10.1.1.1 \
        ip -s link show vlan1  | \
        grep -v bytes | \
        sed -n 3,4p | \
        sed 's/^[ \t]*//' | \
        cut -d" " -f1);\
        \n 1 \
        \n router_10_1_1_1" >> /mnt/sda1/stats/router-internet.csv
