#!/usr/bin/env bash

source ${HOME}/amazonsecreds.sh

username=$(echo -n "${AMAZONSESUSERNAME}" | openssl enc -base64)
password=$(echo -n "${AMAZONSESPASSWORD}" | openssl enc -base64)

DATA_LOCATION=/root/raid_monitor/
CHECK_CMD="ssacli controller all show config"
TODAYS_REPORT="${DATA_LOCATION}/$(date +\"%Y-%m-%d\").log"


$(CHECK_CMD) >> ${TODAYS_REPORT}

read -r -d '' MESSAGE << EOM
EHLO example.com
AUTH LOGIN
${username}
${password}
MAIL FROM: automated@simonscode.host
RCPT TO: simonstruck70@gmail.com
DATA
X-SES-CONFIGURATION-SET: ConfigSet
From: RAID Check Script <automated@simonscode.host>
To: simonstruck70@gmail.com
Subject: RAID Check CHANGED!

$(cat ${TODAYS_REPORT})

Differences:

$(diff ${DATA_LOCATION}/last_report ${TODAYS_REPORT})
.
QUIT
EOM



if ! diff ${DATA_LOCATION}/last_report ${TODAYS_REPORT}; then
   openssl s_client -crlf -quiet -starttls smtp -connect email-smtp.eu-west-1.amazonaws.com:587 < ${MESSAGE}
   rm -f ${DATA_LOCATION}/last_report
   ln -s ${TODAYS_REPORT} ${DATA_LOCATION}/last_report
else
    rm -f ${TODAYS_REPORT}
fi
