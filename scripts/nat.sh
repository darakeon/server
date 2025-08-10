#!/bin/bash
set -e

sysctl -w net.ipv4.ip_forward=1
echo "# allow EC2 as NAT" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

export DEBIAN_FRONTEND=noninteractive
INTERFACE=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if ($i=="dev") print $(i+1)}')
iptables -t nat -A POSTROUTING -o "$INTERFACE" -j MASQUERADE
iptables -A FORWARD -i "$INTERFACE" -o "$INTERFACE" -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i "$INTERFACE" -o "$INTERFACE" -j ACCEPT
apt install -y iptables-persistent
netfilter-persistent save
