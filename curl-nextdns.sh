#!/usr/bin/env bash

/usr/bin/logger -p local0.notice  ${0##*/}[$$] "curl https://link-ip.nextdns.io/64a16f/df66528440d1246c:"

/usr/bin/curl -s https://link-ip.nextdns.io/64a16f/df66528440d1246c | /usr/bin/logger -p local0.notice  ${0##*/}[$$] 