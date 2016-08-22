FROM laincloud/centos-lain:20160503

ADD . /Build/

RUN yum install -y https://packages.icinga.org/epel/7/release/noarch/icinga-rpm-release-7-1.el7.centos.noarch.rpm \
    && pip install supervisor \
    && sed -i '/nodocs/d' /etc/yum.conf \
    && yum install -y icinga2-2.4.10 icinga2-ido-mysql-2.4.10 \
    && yum install -y icingaweb2-2.3.4 icingacli-2.3.4 \
    && yum clean all

RUN cp /Build/supervisord.conf /etc/supervisord.conf \
    && /usr/lib/icinga2/prepare-dirs /etc/sysconfig/icinga2 \
    && icingacli setup token create | tee /Build/icingaweb.token \
    && install -Dm640 -o icinga -g icinga /Build/ido-mysql.conf /etc/icinga2/features-available/ido-mysql.conf \
    && install -Dm640 -o icinga -g icinga /Build/api.conf /etc/icinga2/features-available/api.conf \
    && icinga2 feature enable ido-mysql || true \
    && icinga2 feature enable command || true \
    && icinga2 feature enable compatlog || true \
    && icinga2 api setup || true \
    && echo 'date.timezone = Asia/Shanghai' | tee -a /etc/php.ini \
    && yum install -y msmtp \
    && yum install -y nagios-plugins-all \
    && yum clean all

RUN cp /Build/scripts/* /etc/icinga2/scripts/ \
    && cp /Build/sbin/* /usr/sbin \
    && cp /Build/plugins/* /usr/lib64/nagios/plugins \
    && cp /Build/conf.d/* /etc/icinga2/conf.d \
    && cp -r /Build/icingaweb2/* /etc/icingaweb2/ \
    && mkdir -p /etc/icingaweb2/enabledModules \
    && ln -s /usr/share/icingaweb2/modules/doc /etc/icingaweb2/enabledModules/ \
    && ln -s /usr/share/icingaweb2/modules/iframe /etc/icingaweb2/enabledModules/ \
    && ln -s /usr/share/icingaweb2/modules/monitoring /etc/icingaweb2/enabledModules/ \
    && ln -s /usr/share/icingaweb2/modules/translation /etc/icingaweb2/enabledModules/ \
    && cp /Build/constants.conf /etc/icinga2/ \
    && icinga2 pki new-cert --cn icinga2 --key /etc/icinga2/pki/icinga2.key --csr /etc/icinga2/pki/icinga2.csr \
    && icinga2 pki sign-csr --csr /etc/icinga2/pki/icinga2.csr --cert /etc/icinga2/pki/icinga2.crt

RUN echo '' > /etc/icinga2/conf.d/notifications.conf \
    && echo '' > /etc/icinga2/conf.d/services.conf \
    && echo '' > /etc/icinga2/conf.d/satellite.conf
