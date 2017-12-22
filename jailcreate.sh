#!/bin/bash        
echo "===! Creating new jail !==="
echo "Jail location at /$JAIL_FILENAME"
echo 

sudo mkdir -p /$JAIL_FILENAME

# initialize jail
sudo jk_init -j /$JAIL_FILENAME jk_lsh

while IFS= read -r lib
do

	if [ ! -z "$lib" ]
	then
		echo "Copying $lib"
		sudo jk_cp -j /$JAIL_FILENAME $lib > /dev/null
	fi
	
done < "$REQUIREMENTS"
