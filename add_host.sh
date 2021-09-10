#!/usr/bin/env bash

# Simple script to **safely** add a new host to /etc/hosts

SUCCESS="${GREEN}[+]${RESET}"
FAIL="${RED}[-]${RESET}"
PROCESS="${CYAN}[*]${RESET}"

if [[ -z "$1" || -z "$2" ]] ; then
    echo "$FAIL Insufficient Arguments"
    echo "$0 <IP> <hostname>"
    exit 1
elif ! grep -P "^(\d{1,3}\.){3}\d{1,3}$" <<< "$1" &>/dev/null ; then
    echo "$FAIL Invalid IP Address"
    exit 2
elif ! grep -P "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$" <<< "$2" &>/dev/null ; then
    # Yeah the regex for this is hilarious but stable in my testing
    echo "$FAIL Invalid hostname"
    exit 3
fi

IP_ADDR="$1"
HOSTNAME="$2"

echo "$PROCESS Backing up /etc/hosts in /tmp/hosts"

if cp /etc/hosts /tmp &>/dev/null ; then
    echo "$SUCCESS Backup saved in /tmp"
else
    echo "$FAIL Could not backup /etc/hosts, exiting..."
    exit 4
fi

echo "Adding $IP_ADDR $HOSTNAME to /etc/hosts"

if echo "$IP_ADDR $HOSTNAME" >> /etc/hosts ; then
    echo "$SUCCESS Added $IP_ADDR $HOSTNAME to /etc/hosts"
else
    echo "$FAIL Could not add $IP_ADDR $HOSTNAME to /etc/hosts"
    exit 1
fi

exit 0
