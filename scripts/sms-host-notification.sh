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
export HTTP_PROXY=""
export HTTPS_PROXY=""

/usr/sbin/notify-sms.py --host $SMS_HOST $USERMOBILE "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE"
#/usr/sbin/notify-sms.py $USERMOBILE """$(/usr/bin/printf "%b" "$template")"""
