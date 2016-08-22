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

/usr/sbin/notify-bearychat.py --token $BEARYCHATTOKEN --team $BEARYCHATTEAM --channel $BEARYCHATCHANNEL "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE, $SERVICEOUTPUT"
#/usr/sbin/notify-bearychat.py --token $BEARYCHATTOKEN --team $BEARYCHATTEAM --channel $BEARYCHATCHANNEL """$(/usr/bin/printf "%b" "$template")"""
