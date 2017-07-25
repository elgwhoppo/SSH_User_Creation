#!/bin/bash
 
####
# This script automatically creates user accounts with random passwords.
# It also switches to the user and creates an SSH key
#
# Note 1 for Config: Make sure to run chmod +x against the script location on the machine. 
# 
# Note 2 for Config:  you must place this file inside the visudo directory so it can be run without elevation.
# example: sudo visudo
# 
# user ALL = NOPASSWD: /home/user/makeuser.sh
###
 
if [ $# -lt 1 ]; then
echo "Please supply a user name"
echo "Example: " $0 "jsmith"
exit
fi
 
# Declare local variables, generate random password.
 
newuser=$1
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
 
# Create new user and assign random password.
 
useradd $newuser -m
echo $newuser:$randompw | chpasswd
echo "UserID:" $newuser "has been created with the following password:" $randompw

sudo -u $newuser -H sh -c "cd /home/$newuser; ssh-keygen -f file.rsa -t rsa -N ''"
echo "UserID:" $newuser "has a new SSH public and private key located at /home/"$newuser

echo "Private key is as follows:"
cat "/home/"$newuser"/file.rsa"
