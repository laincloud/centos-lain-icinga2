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

/usr/sbin/notify-pushover.py --token $PUSHOVERTOKEN --user-key $PUSOVERUSERKEY --title "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE" --message """$(/usr/bin/printf "%b" "$template")"""
