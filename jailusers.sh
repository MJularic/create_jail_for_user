#!/bin/bash
if [ -z "$JAIL_FILENAME" ]
then
    echo "Specify JAIL_FILENAME!"
    exit
fi

file="/$JAIL_FILENAME"
if [ ! -d "$file" ]
then
    echo "$file doesn't exist"
    exit
fi

sudo cat /etc/passwd | grep $JAIL_FILENAME >> users.txt
while IFS= read -r user
do

	if [ ! -z "$user" ]
	then
		num=$((num+1))
	fi

done < "users.txt"
rm -r users.txt

num=$((num+1))
USER_NUM=$((USER_NUM+num-1))

for (( i=num; i<=$USER_NUM; i++))
do
	echo "Creating user $JAIL_FILENAME$i"
	echo 
	sudo useradd -m $JAIL_FILENAME$i
	echo "Disabling internet connection for $JAIL_FILENAME$i"
	echo 
	sudo iptables -A OUTPUT -p all -m owner --uid-owner $JAIL_FILENAME$i -j DROP
	sudo sed -i '/^\s*$/d' /etc/rc.local
	sudo sed -i "\$i sudo iptables -A OUTPUT -p all -m owner --uid-owner ${JAIL_FILENAME}${i} -j DROP" /etc/rc.local

done

for (( i=num; i<=$USER_NUM; i++))
do

	echo "Jailing user $JAIL_FILENAME$i"
	echo
	sudo jk_jailuser -j /$JAIL_FILENAME $JAIL_FILENAME$i

done

