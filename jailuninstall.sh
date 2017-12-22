#!/bin/bash 
echo "=====! Uninstalling jailkit tool !===="
cd ./jailkit-2.19
sudo make uninstall > /dev/null
cd ..
rm -r jailkit-2.19*

