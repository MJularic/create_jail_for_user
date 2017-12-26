#!/bin/bash
for (( i=1; i<=$USER_NUM; i++))
do
	echo "Creating user sandbox$i"
	sudo useradd -m sandbox$i
done

for (( i=1; i<=$USER_NUM; i++))
do

	echo "Jailing user sandbox$i"
	sudo jk_jailuser -j $JAIL_FILENAME sandbox$i

done

