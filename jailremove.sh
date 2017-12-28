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

sudo cat /etc/passwd | grep $JAIL_FILENAME > users.txt
while IFS= read -r user
do

	if [ ! -z "$user" ]
	then
		num=$((num+1))
	fi

done < "users.txt"
sudo rm -r users.txt

echo "Removing entries in iptables!"
echo
for (( i=1; i<=num; i++ ))
do
	sudo iptables -D OUTPUT -p all -m owner --uid-owner $JAIL_FILENAME$i -j DROP
done

for (( i=1; i<=num; i++ ))
do
	echo "Removing user $JAIL_FILENAME$i"
	sudo userdel -r $JAIL_FILENAME$i	
done

echo "Removing jail folder /$JAIL_FILENAME"
echo
sudo rm -r /$JAIL_FILENAME

echo "Removing entry in /etc/rc.local to modify iptables upon reboot"
echo
sudo sed -i "/${JAIL_FILENAME}/d" /etc/rc.local

