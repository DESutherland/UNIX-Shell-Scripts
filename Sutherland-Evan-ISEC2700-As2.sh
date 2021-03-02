#!/bin/sh
# This script is for for Assignment Two for ISEC2700
# The name of the script is Sutherland-Evan-ISEC2700-As2.sh
# Author: Evan Sutherland
# Creation Date: 02/20/21
# Last Revision: 02/24/21

# We will flush all existing iptable rules to start
sudo iptables -F

# Next we will list all current rules and send them to a log file
sudo iptables -L -v>/home/esutherland/Documents/iptables/initialstate.log

# Defined Variables for this script are as follows
SERVER1="192.168.4.2"
TECHSUPPORT1="192.168.4.5"
UPDATESERVER="192.168.4.7"

# Setting a rule for the loopback interface to allow all traffic in and out
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Making the firewall Stateful, incoming traffic allowed for ESTABLISHED and RELATED
# Outbound Traffic allowed for ESTABLISHED and NEW
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

# Will allow incoming SSH traffic from TECHSUPPORT1
sudo iptables -I INPUT -i ens33 -p tcp -s $TECHSUPPORT1 --dport 22 -j ACCEPT

# Will allow outgoing FTP traffic to SERVER1 and incoming FTP traffic from UPDATESERVER
sudo modprobe ip_conntrack_ftp
sudo iptables -A OUTPUT -o ens33 -p tcp -d $SERVER1 --dport 21 -j ACCEPT
sudo iptables -A INPUT -i ens33 -p tcp -s $UPDATESERVER --sport 21 -j ACCEPT

# Setting the default policy 
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD DROP

# Saving the new iptable rules to the disk
sudo iptables-save

# Listing the newly configured rules and sending them to a log file
sudo iptables -L -v>/home/esutherland/Documents/iptables/configuredstate.log


