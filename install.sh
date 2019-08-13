#!/usr/bin/env bash

# Main program
install -d /opt
install -m 0755 check_raid.sh /opt/check_raid.sh

# Crontab for daily execution
install -d /etc
cat crontab >> /etc/crontab

# Settings
install -d ${HOME}
install -m 0400 amazonsecreds.sh /${HOME}/amazonsecreds.sh
