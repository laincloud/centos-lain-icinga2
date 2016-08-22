#!/bin/sh
template=`cat <<TEMPLATE
Subject: $NOTIFICATIONTYPE - $HOSTDISPLAYNAME is $HOSTSTATE
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

/usr/bin/printf "%b" "$template" | msmtp --host=${SMTP_HOST} -f "icinga2@lain.example" $USEREMAIL
