#!/usr/bin/env bash

penDev="/dev/sdb1"
mountPoint="/mnt/pen"

echo "sudo mount..."
sudo mount "$penDev" "$mountPoint"
cd "$mountPoint" || return
echo "Folder is" "$(pwd)"
echo "Contents:"
ls -lah