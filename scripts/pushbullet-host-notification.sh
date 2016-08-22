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

/usr/sbin/notify-pushbullet.py --token $PUSHBULLETTOKEN --title "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE" --body """$(/usr/bin/printf "%b" "$template")"""
