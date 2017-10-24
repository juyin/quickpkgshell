#!/bin/sh
#set -x

SERVICE_NAME=new
SERVICE_BASE=/opt/new
BINDIR=${SERVICE_BASE}/bin
LOG_DIR=${SERVICE_BASE}/log
proc_pid=0

if [ ! -f ${LOG_DIR}/monitor.log ];then 
    mkdir -p ${LOG_DIR}
    touch ${LOG_DIR}/monitor.log
fi

get_pid()
{
    proc_pid=`pidof ${BINDIR}/${SERVICE_NAME}`  
}

monitoring()
{
    monitoring_count=1
    while [ 1 ]
    do       
        get_pid
        if [ -z $proc_pid ];then        
            service ${SERVICE_NAME} start
            echo "`date` Service restarted as ${SERVICE_NAME} was not running" >>${LOG_DIR}/monitor.log
            break;
        fi  
    done
}

echo "========================================================================================">>${LOG_DIR}/monitor.log
echo "`date` $0 Monitoring Script started "                                                    >>${LOG_DIR}/monitor.log

while [ 1 ]
do
    monitoring
    sleep 60
done

