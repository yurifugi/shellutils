#!/usr/bin/env bash

/usr/bin/logger -p local0.notice -t os-updater.sh Started 

/usr/bin/logger -p local0.notice -t os-updater.sh apt-get update
/usr/bin/apt-get update | /usr/bin/logger -p local0.notice -t os-updater.sh 

/usr/bin/logger -p local0.notice -t os-updater.sh apt-get upgrade
/usr/bin/apt-get upgrade -y 2>&1 | /usr/bin/logger -p local0.notice -t os-updater.sh

/usr/bin/logger -p local0.notice -t os-updater.sh apt-get autoremove
/usr/bin/apt-get autoremove -y 2>&1 | /usr/bin/logger -p local0.notice -t os-updater.sh

/usr/bin/logger -p local0.notice -t os-updater.sh apt-get clean
/usr/bin/apt-get clean -y 2>&1  | /usr/bin/logger -p local0.notice -t os-updater.sh

/usr/bin/logger -p local0.notice -t os-updater.sh Finished 