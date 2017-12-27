#!/bin/bash
for (( i=1; i<=$USER_NUM; i++))
do
	echo "Creating user sandbox$i"
	echo 
	sudo useradd -m sandbox$i
	echo "Disabling internet connection for sandbox$i"
	echo 
	sudo iptables -A OUTPUT -p all -m owner --uid-owner sandbox$i -j DROP
	#sudo sed -i "/exit 0/i \\sudo iptables -A OUTPUT -p all -m owner --uid-owner sandbox${i} -j DROP\\" /etc/rc.local
	sudo sed -i '/^\s*$/d' /etc/rc.local
	sudo sed -i "\$i sudo iptables -A OUTPUT -p all -m owner --uid-owner sandbox${i} -j DROP" /etc/rc.local

done

for (( i=1; i<=$USER_NUM; i++))
do

	echo "Jailing user sandbox$i"
	echo
	sudo jk_jailuser -j /$JAIL_FILENAME sandbox$i

done

