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

/usr/sbin/notify-bearychat.py --token $BEARYCHATTOKEN --team $BEARYCHATTEAM --channel $BEARYCHATCHANNEL "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE"
#/usr/sbin/notify-sms.py $USERMOBILE """$(/usr/bin/printf "%b" "$template")"""
