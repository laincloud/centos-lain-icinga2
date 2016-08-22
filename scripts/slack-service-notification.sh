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

/usr/sbin/notify-slack.py --token $SLACKTOKEN --channel $SLACKCHANNEL "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE"
#/usr/sbin/notify-sms.py $USERMOBILE """$(/usr/bin/printf "%b" "$template")"""
