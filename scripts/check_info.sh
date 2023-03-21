#!/bin/bash
mydevice=`(tmsh list sys global-settings hostname | grep hostname | awk '{print $2}')`
mymgmt=`(tmsh list sys management-ip | awk -F "/" '{print $1}' | awk '{print $3}')`
myserial=`(tmsh show sys hardware | egrep "Appliance Serial|Chassis Serial" | awk '{print $3}')`
mycha=`(tmsh show sys hardware | grep "Name" | grep BIG | awk '{print $2" "$3 }')`
myplat=`(tmsh show sys hardware | grep -A1 "System Information" | grep Type  | awk '{print $2}')`
provmod=`(tmsh list sys provision | grep -B 1 level | grep provision | awk '{print $3}'| tr '\n' ', ')`
echo ${mydevice}, ${mymgmt}, ${myserial}, ${mycha}, ${myplat}, ${provmod} > /var/tmp/$HOSTNAME.check_info
