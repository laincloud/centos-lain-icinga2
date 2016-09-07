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
export HTTP_PROXY=""
export HTTPS_PROXY=""

/usr/sbin/notify-sms.py --host $SMS_HOST $USERMOBILE $SMS_TEMPLATE_ID "$NOTIFICATIONTYPE - $HOSTDISPLAYNAME - $SERVICEDISPLAYNAME is $SERVICESTATE"
#/usr/sbin/notify-sms.py $USERMOBILE """$(/usr/bin/printf "%b" "$template")"""
