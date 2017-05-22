#!/bin/bash

# author: jitao.chu@travelzen.com
# date : Thu May  8 10:45:37 CST 2014
# revision1 at Fri May 16 12:53:24 CST 2014
# run under crontab 
# config in /etc/cron.d/$0

LOGDIR='/data/log/tops/history'
DATE=`date +%Y-%m-%d -d '2 month ago'`
OLDLOG="${LOGDIR}/tops*-${DATE}.log.zip"

[[ ! -d ${LOGDIR} ]] && exit

for logfile in `ls ${LOGDIR}/*.log`
do
    zip ${logfile}.zip ${logfile}
    [[ $? -eq 0 ]] && rm -f ${logfile}
    chgrp tomcat ${logfile}.zip
    chmod 640 ${logfile}.zip
done

[[ -n ${OLDLOG} ]] && rm -f ${OLDLOG}
