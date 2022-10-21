#!/bin/bash



# RUN AS ROOT 

#Secure machine task 

#1. Check and enable Firewall

echo "Starting UFW configuration"

echo '##############################################################'

ufw status

ufw default allow outgoing 

ufw default deny incoming

ufw allow ssh

ufw enable

echo "**** DONE***"

echo '##############################################################'

echo ' '





#2. Check for any users with empty passwords

# For testing create empty user is requried:

useradd abc 

passwd -d abc

echo "Checking for users that do not have a password set"

echo "List:"

cat /etc/shadow | awk -F: '($2==""){print $1}'

echo '##############################################################'

echo ' '



# Enable SSH service(auto start on reboot)

echo 'Enabling ssh to auto start on reboot'

systemctl enable ssh >> /tmp/logs

systemctl status ssh | grep -i enabled 

echo 'SSH configured'

echo '##############################################################'

echo ' '



# Set ulimit(number of open files) to 10000 for all users

echo "Setting max open files for all users to 10000"

ulimit -n 10000

echo 'Ulimit for open files now set to: '

ulimit -a | grep 'open files'

echo '##############################################################'

echo ' '





# Set net.netfilter.nf_conntrack_max value to 3097152

# Configure conntrack_max value, enable the module, set the value, 

echo 'Enabling modprob'

modprobe ip_conntrack

echo "net.netfilter.nf_conntrack_max=3097152" >> /etc/sysctl.conf

echo "The sysctl is now configured"

sysctl -p

echo '##############################################################'

echo ' '





# Install curl 

echo "Installing curl pkg on this system"

apt-get install curl -y >> /tmp/log

echo 'the curl version isntaller is: '

curl --version

echo '##############################################################'

echo ' '





# Disable BASH History 

echo 'Disabling BASH history'

echo 'set +o history' >> /etc/profile

echo '##############################################################'

echo ' '

