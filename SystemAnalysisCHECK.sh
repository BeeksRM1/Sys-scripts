#!/bin/bash

##Linux System Analisis##
###simply copy script to the client machine###
####Ensure correct priveledges####
#####If not > $chmod 755 "script name"##### 
######This will make the script executable for root######

#Script to gather critical overview system information#

####################
#SYSTEM INFORMATION#
####################

echo "SYSTEM INFORMATION>>"
echo "--------------------"
date;
echo "uptime:"
uptime
echo "--------------------"
echo "Version:"
uname -a
echo "--------------------"
printf "\n"

#Shows active  users and sec audit logins#
echo "Currently connected:"
w
echo "--------------------"
echo "Last logins:"
last -a |head -3
echo "--------------------"
printf "\n"

#Displays Memory and Disk usage (free/used)#
echo "Disk and memory usage:"
df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
echo "--------------------"
start_log=`head -1 /var/log/messages |cut -c 1-12`
oom=`grep -ci kill /var/log/messages`
echo -n "OOM errors since $start_log :" $oom
echo ""
echo "--------------------"
printf "\n"

#Details the network HW/Int Info#
echo "Net Hardware:"
lshw -class network
printf "\n"
echo "--------------------"
printf "\n"

#List users and Wheel members#
echo "Users:"
cat /etc/passwd
echo "--------------------"
echo "Wheel Group:"
getent group wheel
printf "\n"
echo "--------------------"
printf "\n"

#Shows current process and highest resource usage#
echo "Process Info>>"
echo "Utilization and most expensive processes:"
top -b |head -5
echo
top -b |head -10 |tail -4
printf "\n"
echo "--------------------"
printf "\n"

echo "Processes:"
ps auxf --width=200 | tail -20
printf "\n"
echo "--------------------"
printf "\n"

#Shows info on  the VM resources#
echo "vmstat:"
vmstat -V 1 5
vmstat 1 5
printf "\n"
echo "--------------------"
printf "\n"

#################
#SECURITY CHECKS#
#################

#Checks if SElinux is in use and shows settings#
echo "Security Services>>"
echo "--------------------"
printf "\n"
echo "SElinux:"
sestatus
printf "\n"
echo "--------------------"
printf "\n"

#Checks firewalld status#
echo "Firewall Status:"
echo "--------------------"
printf "\n"
echo "Checking firewalld status"
printf "\n"

#Checks if service active > outputs answer#
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

#If fwd service actiive then lists fwd rules#
if
systemctl status firewalld | grep "active (running)" > /dev/null
then
echo "firewalld rules:"
firewall-cmd --list-all
echo "--------------------"
#If service not active > checks for IPtables#
else
printf "\n"
echo "Checking for IPtables service"
printf "\n"
systemctl status iptables
printf "\n"
#If service running lists IPtables rules#
echo "IPtables rules:"
iptables -vnL
printf "\n"
echo "--------------------"
printf "\n"
#Confirms the system is running IPtables"
echo "This sytem is running the IPtables service"
printf "\n"
echo "---------------------"
fi
printf "\n"

#####################
#NETWORK INFORMATION#
#####################

#Lists network interfaces#
echo "Network Info>>"
echo "--------------------"
echo "Interfaces:"
ifconfig -a
echo "--------------------"
printf "\n"

#Checks external connectivity#
echo "Connectivity Check:"
ping -c 4 8.8.8.8
printf "\n" 
echo "--------------------"
printf "\n"

#Shows routing table entries#
echo "Routes:"
route -n
printf "\n"
echo "--------------------"
printf "\n"

#Shows current open TCP ports
echo "Open TCP ports:"
netstat -plunt
printf "\n"
echo "--------------------"
printf "\n"

#Lists current established connections#
echo "Current connections:"
ss -s
echo "--------------------"

