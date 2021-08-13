#!/usr/bin/env bash

SYS_LOGS_PATH="/var/log"

find "$SYS_LOGS_PATH" -mtime +30 -exec rm-rf {} \;

