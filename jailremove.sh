#!/bin/bash
echo "Counting the number of created sandbox users"
sudo cat /etc/passwd | grep sandbox > users.txt
while IFS= read -r user
do

	if [ ! -z "$user" ]
	then
		num=$((num+1))
	fi

done < "users.txt"

for (( i=1; i<=num; i++ ))
do
	echo "Removing user sandbox$i"
	sudo userdel -r sandbox$i	
done

echo "Removing jail folder $JAIL_FILENAME"
sudo rm -r $JAIL_FILENAME
sudo rm -r users.txt
