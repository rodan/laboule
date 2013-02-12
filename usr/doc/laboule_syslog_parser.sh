#!/bin/bash

# strings that define failed ssh login attempts
attempt='(not allowed because none)|(Failed password for)'

# make sure some IPs don't reach laboule
exclude='(127.0.0.1)|(foo)'

l_socket="/var/lib/laboule/msg"

cat | while read LINE; do
    IP=$(echo "${LINE}" | grep -Ei "${attempt}" | sed 's|.* \([0-9a-fA-F\.:]\{7,\}\).*|\1|' | grep -Ev "${exclude}")
    [ ! -z "${IP}" ] && {
        echo "${IP} auth count" > ${l_socket}
    }
done

# sample config for syslog-ng:

## send remote login attempts to laboule
#filter f_auth { facility(auth, authpriv); };
#destination laboule_syslog_parser {
#    program("su -s /bin/bash laboule -c /local/FIXME/laboule_syslog_parser.sh" template("${MSGHDR}${MSG}\n"));
#};
#log { source(s_local); filter(f_auth); destination(laboule_syslog_parser); };

