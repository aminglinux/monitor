#!/bin/bash
while :
do
for i in `seq 1 100`; do /usr/bin/mysql -uuch -h172.7.15.5 -P 3307 -pHNDSFnx549sJALXMNGA -e "select version()"; done 2>/tmp/3307.err |wc -l>/tmp/line.txt
n=`cat /tmp/line.txt`
if [ $n -lt 200 ]
then
    date >>/tmp/mon_mysql.err
    /bin/bash ../mail/mail.sh  db1_3307_not_connect /tmp/3307.err
fi
sleep 10
done
