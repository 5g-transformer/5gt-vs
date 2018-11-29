
VNFNAME=$1
VNFDNAME=/home/trans/Documents/tacker/$1"-vnfd"
VNFDFILE=/home/trans/Documents/tacker/$1"-vnfd.yaml"
#echo 3:$3 4:$4 5:$5 6:$6
#if [ "${2}" == "ssh" ] ; then
#	sudo cp ubuntu1604-vnfd.yaml $VNFDFILE
#
#else
#	sudo cp ubuntu1604-vnfd.yaml $VNFDFILE
#fi


echo $VNFNAME" "$VNFDNAME" "$VNFDFILE
openstack vnf descriptor create --vnfd-file $VNFDFILE $VNFDNAME
sleep 5
openstack vnf create --vnfd-name $VNFDNAME  $VNFNAME
SERVERSTATUS=`openstack vnf list | grep $VNFNAME | awk '{print $4, $9}'`

until [ "${VNFSTATUS}" == "ACTIVE"  ]
do
	sleep 5
	echo $VNFSTATUS
	echo "wait for create"
	VNFSTATUS=`openstack vnf list | grep $VNFNAME | awk '{print $9}'`
	if [ "${VNFSTATUS}" == "ERROR" ] ; then
		break;
	fi
done
echo "VNFNAME is " $VNFNAME " input: " $1
VNFIP=`openstack vnf list|grep $VNFNAME|awk '{print $7}'|sed 's/}//g'|sed 's/"//g'`
SERVERID=`openstack vnf list|grep $VNFIP| awk '{print $2}'`
echo "create OK"
echo "server id is "$SERVERID
echo "vnf access ip is "$VNFIP


#
#SERVERSTATUS=`openstack server list|grep ubuntu1604| awk '{print $6}'`





#openstack server list
#openstack console url show $SERVERID
#if [ "${SERVERSTATUS}" == "ACTIVE" ] ; then
#	echo "create VNF done...."
#	exit 1
#fi
