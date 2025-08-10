#!/bin/bash
set -e

# original command
# sudo sysctl -w net.ipv4.ip_forward=1

echo "# allow EC2 as NAT" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

apt update
apt install -y iptables-persistent

iptables -t nat -A POSTROUTING -o eth0 -s 172.31.0.0/16 -j MASQUERADE

# export DEBIAN_FRONTEND=noninteractive
# INTERFACE=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if ($i=="dev") print $(i+1)}')
# iptables -t nat -A POSTROUTING -o "$INTERFACE" -j MASQUERADE
# iptables -A FORWARD -i "$INTERFACE" -m state --state RELATED,ESTABLISHED -j ACCEPT
# iptables -A FORWARD -o "$INTERFACE" -j ACCEPT

netfilter-persistent save

echo "*---------------------------------------------------------*"
echo "|                                                         |"
echo "|                                                         |"
echo "|   REMEMBER disable source/destination check ON EC2!!!   |"
echo "|                                                         |"
echo "|                                                         |"
echo "*---------------------------------------------------------*"

# for check receiving:
# sudo tcpdump -i ens5 icmp
