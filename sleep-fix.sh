#!/usr/bin/env bash

set -x

if [[ $(id -u) -ne 0 ]] ; 
then 
    echo "Please run with sudo."
    exit 1
fi

MY_IP="10.1.1"
MY_IP_NOW=$(ip -o -4 addr show dev enp3s0 | cut -d' ' -f7 | cut -d'/' -f1)

echo "$MY_IP_NOW" | grep "$MY_IP"
HAS_MY_IP=$?

if [[ "$HAS_MY_IP" = "0" ]]
then
    echo "Found IP as $MY_IP_NOW."
else
    echo "IP not found."
    echo "Modprobing alx."
    modprobe -r alx
    modprobe -i alx
fi
