#!/bin/bash
stat=`curl --connect-timeout 3 -I www.apelearn.com 2>/tmp/502.log | grep HTTP |awk '{print $2}'`
ip=`dig www.apelearn.com |grep 'IN\sA' |tail -n1 |awk '{print $NF}'`
if [ -z $stat ] || [ $stat -ne "200" ]
then
    /bin/bash ../mail/mail.sh apelearn_$stat $ip /tmp/502.log
fi
echo "`date +%T` apelearn $stat"
