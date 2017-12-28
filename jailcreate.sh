#!/bin/bash        
if [ -z "$JAIL_FILENAME" ]
then
    echo "Specify JAIL_FILENAME!"
    exit
fi

file="/$JAIL_FILENAME"
if [ -d "$file" ]
then
	echo "$file already exists, specify another JAIL_FILENAME!"
	exit
fi
file="$REQUIREMENTS"
if [ ! -f "$file" ]
then
    echo "$file doesn't exist, specify full path in REQUIREMENTS"
    exit
fi

echo "Creating new jail !"
echo "Jail location at /$JAIL_FILENAME"
echo
sudo mkdir /$JAIL_FILENAME

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
