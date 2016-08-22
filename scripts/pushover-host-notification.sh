#!/bin/sh
template=`cat <<TEMPLATE
***** Icinga  *****

Notification Type: $NOTIFICATIONTYPE

Host: $HOSTALIAS
Address: $HOSTADDRESS
State: $HOSTSTATE

Date/Time: $LONGDATETIME

Additional Info: $HOSTOUTPUT

Comment: [$NOTIFICATIONAUTHORNAME] $NOTIFICATIONCOMMENT
TEMPLATE
`

source /etc/icinga2/scripts/util.sh

/usr/sbin/notify-pushover.py --token $PUSHOVERTOKEN --user-key $PUSOVERUSERKEY --title "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE" --message """$(/usr/bin/printf "%b" "$template")"""
