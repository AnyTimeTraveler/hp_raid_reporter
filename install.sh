#!/usr/bin/env bash

install -d /opt
install -m 0755 check_raid.sh /opt/check_raid.sh

install -d /etc
cat crontab >> /etc/crontab
