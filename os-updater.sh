#!/usr/bin/env bash

/usr/bin/logger -p local0.notice ${0##*/}[$$] "Started" 

/usr/bin/logger -p local0.notice ${0##*/}[$$] "apt-get update:"
/usr/bin/apt-get update | /usr/bin/logger -p local0.notice ${0##*/}[$$]

/usr/bin/logger -p local0.notice  ${0##*/}[$$] "apt-get upgrade:"
/usr/bin/apt-get upgrade -y 2>&1 | /usr/bin/logger -p local0.notice ${0##*/}[$$] 

/usr/bin/logger -p local0.notice  ${0##*/}[$$]  "apt-get autoremove:"
/usr/bin/apt-get autoremove -y 2>&1 | /usr/bin/logger -p local0.notice ${0##*/}[$$] 

/usr/bin/logger -p local0.notice  ${0##*/}[$$] "apt-get clean:"
/usr/bin/apt-get clean -y 2>&1  | /usr/bin/logger -p local0.notice ${0##*/}[$$] 

/usr/bin/logger -p local0.notice  ${0##*/}[$$] "Finished."