#!/bin/bash
   
    log=$1  
    t_s=`date +%s`
    t_s2=`date -d "2 hours ago" +%s`
    if [ ! -f /tmp/$log ]
    then
        echo $t_s2 > /tmp/$log
    fi
    t_s2=`tail -1 /tmp/$log|awk '{print $1}'`
    echo $t_s>>/tmp/$log
    v=$[$t_s-$t_s2]
        echo $v
    if [ $v -gt 3600 ]
    then    
        /usr/local/php/bin/php ../mail/mail.php "$1 $2" "$3"
        echo "0" > /tmp/$log.txt
    else    
        if [ ! -f /tmp/$log.txt ]
        then
            echo "0" > /tmp/$log.txt
        fi
        nu=`cat /tmp/$log.txt`
        nu2=$[$nu+1]
        echo $nu2>/tmp/$log.txt
        if [ $nu2 -gt 10 ]
        then    
            /usr/local/php/bin/php ../mail/mail.php "trouble continue 10 min $1 $2 " "$3"
             echo "0" > /tmp/$log.txt
        fi      
    fi      

