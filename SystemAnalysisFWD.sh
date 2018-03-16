#!/bin/bash

##System Analisis##

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

echo "Currently connected:"
w
echo "--------------------"
echo "Last logins:"
last -a |head -3
echo "--------------------"
printf "\n"

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

echo "Users:"
cat /etc/passwd
echo "--------------------"
echo "Wheel Group:"
getent group wheel
echo "--------------------"
printf "\n"

echo "Process Info>>"
echo "--------------------"
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

echo "vmstat:"
vmstat -V 1 5
vmstat 1 5
printf "\n"
echo "--------------------"
printf "\n"

echo "Security Status>>"
echo "--------------------"
sestatus
echo "--------------------"
printf "\n"

######################################

systemctl status firewalld
echo "--------------------"
printf "\n"

systemctl status iptables
printf "\n"
echo "--------------------"
printf "\n"

#######################################

echo "firewalld rules"
firewall-cmd --list-all
echo "--------------------"
printf "\n"

#######################################


echo "Network Info>>"
echo "--------------------"
echo "Interfaces:"
ifconfig -a
echo "--------------------"

echo "Connectivity Check:"
ping -c 4 8.8.8.8
echo "--------------------"

echo "Routes:"
route -n
printf "\n"
echo "--------------------"
printf "\n"

echo "Net Hardware:"
lshw -class network
printf "\n"
echo "--------------------"
printf "\n"

echo "Open TCP ports:"
netstat -plunt
printf "\n"
echo "--------------------"
printf "\n"

echo "Current connections:"
ss -s
echo "--------------------"

