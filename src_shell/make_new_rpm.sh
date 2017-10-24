###################################################################
#   make_new_rpm.sh file
#
#   This file aims to build im rpm file
###################################################################
#!/bin/bash
#set -x -v

SERVICE_NAME=new
RPM_PATH=${PWD}
SERVICE_BASE=/opt/new
BINDIR=${SERVICE_BASE}/bin
ETCDIR=${SERVICE_BASE}/etc

VERSION_INFO=1.0.0
RELEASE=0.0
RELEASE_TIME=$(date +'%Y/%m/%d %H:%M:%S')

cd ${RPM_PATH} 
echo "   Starting Building RPM Specific Directory"

\rm -rf rpm

mkdir -p rpm${BINDIR}
mkdir -p rpm${ETCDIR}


echo "  Starting Moving Binaries"
cp  ${SERVICE_NAME}.bin           rpm${BINDIR}/${SERVICE_NAME}
cp  ${SERVICE_NAME}.service       rpm${ETCDIR}/${SERVICE_NAME}
cp  monitor_${SERVICE_NAME}.sh    rpm${ETCDIR}/monitor_${SERVICE_NAME}.sh

cksum rpm${BINDIR}/${SERVICE_NAME} > rpm${ETCDIR}/cksum
echo "Version: "${SERVICE_NAME}-${VERSION_INFO}-${RELEASE} > rpm${ETCDIR}/release_info.txt
echo "Time:    "${RELEASE_TIME}>> rpm${ETCDIR}/release_info.txt

echo "%_rpmdir		${RPM_PATH}/RPMS" >> $HOME/.rpmmacros

rpmbuild --buildroot ${RPM_PATH}/rpm -bb ${RPM_PATH}/${SERVICE_NAME}.spec

echo " RPM Package Build.......Done"
exit
\rm -rf rpm
