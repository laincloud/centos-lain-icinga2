#!/bin/bash
chmod -R icinga:icinga /var/lib/icinga2
chmod -R root:icinga /etc/icinga2
chmod -R apache:icinga /etc/icingaweb2
exec supervisord
