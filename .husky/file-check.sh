#!/usr/bin/env sh

FILE=/etc/resolv.conf
test -f /etc/resolv.conf && echo "$FILE exists."

if [ -f "$FILE" ]; then
    echo "$FILE exists."
fi