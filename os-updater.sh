#!/usr/bin/env bash

/usr/bin/logger -p local0.notice -t os-updater -------- Update Started -------- 

/usr/bin/logger -p local0.notice -t os-updater Started apt-get update
/usr/bin/apt-get update | /usr/bin/logger -p local0.notice -t os-updater 

/usr/bin/logger -p local0.notice -t os-updater Started apt-get upgrade
/usr/bin/apt-get upgrade -y 2>&1 | /usr/bin/logger -p local0.notice -t os-updater

/usr/bin/logger -p local0.notice -t os-updater Started apt-get autoremove
/usr/bin/apt-get autoremove -y 2>&1 | /usr/bin/logger -p local0.notice -t os-updater

/usr/bin/logger -p local0.notice -t os-updater Started apt-get clean
/usr/bin/apt-get clean -y 2>&1  | /usr/bin/logger -p local0.notice -t os-updater

/usr/bin/logger -p local0.notice -t os-updater -------- Update Finished ------- 