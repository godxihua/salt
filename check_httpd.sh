#!/bin/sh
A=`netstat -tunpl|grep httpd|wc -l`
if [ $A -ne 1 ];then
    systemctl stop keepalived
else
    echo 'service is ok'
fi
