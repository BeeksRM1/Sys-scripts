#!/bin/bash

################################
#CONFIGURE CENTOS7 FOR IPTABLES#
################################

#Script will check firewalld > if active > disable then Install and enable IPtables# 
#Then list the current rules#

#check if firewalld installed#

printf "\n"
echo "Checking firewalld  install"
printf "\n"

if
systemctl status firewalld | grep "active (running)" > /dev/null
then
echo "firewalld service is Active"
printf "\n"
else
echo "firewalld service is not running"
printf "\n"
echo "--------------------"
fi

#If installed disable#

printf "\n"
echo "Disabling the firewalld service"
systemctl stop firewalld
systemctl disable firewalld
systemctl mask firewalld
printf "\n"
sleep 3
printf "\n"
echo "Checking status"
printf "\n"
if
systemctl status firewalld | grep "inactive" > /dev/null
sleep 3
then
echo "--------------------"
echo "firewalld has been disabled"
echo "--------------------"
fi

#check if IPtables installed#
#If not > install#

printf "\n"
echo "Checking for the iptables-service"
printf "\n"


/sbin/service iptables status >/dev/null 2>&1
if [ $? = 0 ];
then
echo "IPtables already installed"
else
echo "Installing IPtables"
fi

yum -y install iptables-services
echo "IPtables installed"
printf "\n"
sleep 3

echo "Enabling IPtables"
systemctl enable iptables
systemctl start iptables
sleep 5
printf "\n"
echo "IPtables has been enabled :)"
echo "--------------------"
printf "\n"
printf "\n"

#List all IPtables chains and rules#
echo "Listing Current Configuration >>"
echo "--------------------"

#List rules#
printf "\n"
echo "Default rules"
echo "--------------------"
iptables -L
printf "\n"

#view the mangle table#
printf "\n"
echo "Mangle table"
echo "--------------------"
iptables -t mangle --list
printf "\n"

#view the nat table#
printf "\n"
echo "NAT table"
echo "--------------------"
iptables -t nat -vnL
printf "\n"

#view the raw table#
printf "\n"
echo "RAW table"
echo "--------------------"
iptables -t raw --list
printf "\n"
sleep 3

echo "--------------------"
echo ">> Process Complete"
echo "--------------------"

