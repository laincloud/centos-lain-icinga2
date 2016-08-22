#!/bin/sh
template=`cat <<TEMPLATE
***** Lain Icinga  *****

Notification Type: $NOTIFICATIONTYPE

Service: $SERVICEDESC
Host: $HOSTALIAS
Address: $HOSTADDRESS
State: $SERVICESTATE

Date/Time: $LONGDATETIME

Additional Info: $SERVICEOUTPUT

Comment: [$NOTIFICATIONAUTHORNAME] $NOTIFICATIONCOMMENT
TEMPLATE
`

source /etc/icinga2/scripts/util.sh

/usr/sbin/notify-pushbullet.py --token $PUSHBULLETTOKEN --title "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE" --body """$(/usr/bin/printf "%b" "$template")"""
