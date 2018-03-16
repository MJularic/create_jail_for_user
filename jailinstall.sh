#!/bin/bash 
echo 'You only need to run setup once'
echo

echo 'Downloading jailkit tool!'
wget http://olivier.sessink.nl/jailkit/jailkit-2.19.tar.gz > /dev/null

echo 'Unpacking jailkit tool!'
tar -xf jailkit-2.19.tar.gz
rm -r jailkit-2.19.tar.gz
cd  ./jailkit-2.19

echo 'Installing gcc compiler'
sudo apt-get install build-essential

echo 'Installing jailkit tool!'
./configure > /dev/null && make > /dev/null
sudo make install > /dev/null

echo -e '\n\nInstallation successful!'

