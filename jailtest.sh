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

sudo cp TCPclient.py /$JAIL_FILENAME
sudo cp proc_test.py /$JAIL_FILENAME

sudo cat /etc/passwd | grep $JAIL_FILENAME > users.txt
while IFS= read -r user
do

	if [ ! -z "$user" ]
	then
		num=$((num+1))
	fi

done < "users.txt"
rm -r users.txt

for (( i=1; i<=num; i++ ))
do
    echo "TESTING USER $JAIL_FILENAME$i"
	sudo prlimit --nproc=1 chroot --userspec=$JAIL_FILENAME$i /jail python3.6 proc_test.py
    python3.6 TCPserver.py & sudo prlimit --nproc=1 chroot --userspec=$JAIL_FILENAME$i /jail python3.6 TCPclient.py &
    wait
    echo
done

sudo rm -r /$JAIL_FILENAME/TCPclient.py
sudo rm -r /$JAIL_FILENAME/proc_test.py
