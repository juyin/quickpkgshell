#!/bin/sh
#set -x
if [ -z $1 ];then
   echo
   echo "Please input service name!"
   echo
   exit
fi
SERVICE_NAME=$1
SRC_DIR=${PWD}/src_shell
DST_DIR=${PWD}/output
INSTALL_DIR=/opt
SERVICE_BASE=/opt/${SERVICE_NAME}
SERVICE_BASE_STR="\/opt\/${SERVICE_NAME}"
TEST_SHELL=YES

\rm -rf ${DST_DIR}
mkdir   ${DST_DIR}

NEW_SERVICE_MAKE_RPM_SH=${DST_DIR}/make_${SERVICE_NAME}_rpm.sh
NEW_SERVICE_MONITOR=${DST_DIR}/monitor_${SERVICE_NAME}.sh
NEW_SERVICE_SH=${DST_DIR}/${SERVICE_NAME}.service
NEW_SERVICE_SPEC=${DST_DIR}/${SERVICE_NAME}.spec

echo "Starting generate ${SERVICE_NAME} shell,please wait..."


#生成各脚本文件名
cp ${SRC_DIR}/make_new_rpm.sh  ${NEW_SERVICE_MAKE_RPM_SH}
cp ${SRC_DIR}/monitor_new.sh   ${NEW_SERVICE_MONITOR}
cp ${SRC_DIR}/new.service      ${NEW_SERVICE_SH}
cp ${SRC_DIR}/new.spec         ${NEW_SERVICE_SPEC}

sed -i "s/SERVICE_NAME=.*$/SERVICE_NAME=${SERVICE_NAME}/g" ${NEW_SERVICE_MAKE_RPM_SH}
sed -i "s/SERVICE_NAME=.*$/SERVICE_NAME=${SERVICE_NAME}/g" ${NEW_SERVICE_MONITOR}
sed -i "s/SERVICE_NAME=.*$/SERVICE_NAME=${SERVICE_NAME}/g" ${NEW_SERVICE_SH}

sed -i "s/%define SERVICE_NAME.*$/%define SERVICE_NAME ${SERVICE_NAME}/g" ${NEW_SERVICE_SPEC}  
sed -i "s/Name:.*$/Name:           ${SERVICE_NAME}/g" ${NEW_SERVICE_SPEC}


sed -i "s|\(%define SERVICE_BASE\)\(.*\)|\1 ${INSTALL_DIR}\/%{SERVICE_NAME}|" ${NEW_SERVICE_SPEC}


sed -i "s|\(SERVICE_BASE=\)\(.*\)|\1${SERVICE_BASE_STR}|" ${NEW_SERVICE_MAKE_RPM_SH}
sed -i "s|\(SERVICE_BASE=\)\(.*\)|\1${SERVICE_BASE_STR}|" ${NEW_SERVICE_MONITOR}
sed -i "s|\(SERVICE_BASE=\)\(.*\)|\1${SERVICE_BASE_STR}|" ${NEW_SERVICE_SH}


echo "Generate ${SERVICE_NAME} shell done..."


if [ ${TEST_SHELL} == "YES" ];then
	cp ${SRC_DIR}/new.bin  ${DST_DIR}/${SERVICE_NAME}.bin
	cd ${DST_DIR}
	${NEW_SERVICE_MAKE_RPM_SH}
	cd RPMS
	rpm -ivh ${SERVICE_NAME}*
fi



