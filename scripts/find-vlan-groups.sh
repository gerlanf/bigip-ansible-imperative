#!/bin/bash
SSHPASS=f3D3xr00t!
echo "Hostname,Server IP,Server MAC,Server Vlan"> servers.csv

#start loop
while IFS=, read DeviceIP DeviceLabel
do
echo "Processing Device: "$DeviceIP" ("$DeviceLabel")"
	sshpass -p$SSHPASS ssh -o StrictHostKeyChecking=no root@$DeviceIP <<'FINDSERVERS' >> servers.csv
hostname=$(tmsh list sys global-settings hostname|grep hostname|awk '{print $2}')
vlans=$(ifconfig -a | grep vlan | grep - | awk '{print $1}' | awk -F\- -v vlan=vlan '{print vlan$2}' | sed 's/://'); for vlan in $vlans; do tmsh show net arp all | grep $vlan | grep -v incomplete|sed 's/\/Common\///g'|awk -v host="$hostname" '{print host "," $2 "," $3 "," $4}'; done
FINDSERVERS
done < devices.csv

AllVLANS=$(cat servers.csv|grep -v 'Server Vlan'|awk -F\, '{print $4}'|uniq)
for UniqueVLAN in $AllVLANS
do
	ServerCount=$(cat servers.csv|grep $UniqueVLAN|wc -l)
	echo "The VLAN '$UniqueVLAN' has $ServerCount servers needing attention.">> TotalCounts.txt
	echo "The VLAN '$UniqueVLAN' has $ServerCount servers needing attention."
done
