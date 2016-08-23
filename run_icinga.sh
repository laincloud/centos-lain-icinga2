#!/bin/bash
usermod -a -G icingaweb2 apache;
chown -R icinga:icinga /var/lib/icinga2
chown -R icinga:icinga /etc/icinga2
chown -R apache:icinga /etc/icingaweb2
chmod u+s /bin/ping
exec supervisord
