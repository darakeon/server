#!/bin/bash
set -e

sysctl -w net.ipv4.ip_forward=1
echo "# allow EC2 as NAT" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

export DEBIAN_FRONTEND=noninteractive
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth0 -j ACCEPT
apt install -y iptables-persistent
netfilter-persistent save
