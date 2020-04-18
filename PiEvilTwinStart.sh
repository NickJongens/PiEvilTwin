#!/bin/bash

service apache2 start
sleep 1
ifconfig wlan0 down
macchanger -A wlan0
ifconfig wlan0 up
sleep 1
hostapd -B /etc/hostapd/hostapd.conf
sleep 2
ifconfig br0 up
ifconfig br0 10.1.1.1 netmask 255.255.255.0
sysctl net.ipv4.ip_forward=1
iptables --flush
iptables -t nat --flush
iptables -t nat -A PREROUTING -i br0 -p udp -m udp --dport 53 -j DNAT --to-destination 10.1.1.1:53
iptables -t nat -A PREROUTING -i br0 -p tcp -m tcp --dport 80 -j DNAT --to-destination 10.1.1.1:80
iptables -t nat -A PREROUTING -i br0 -p tcp -m tcp --dport 443 -j DNAT --to-destination 10.1.1.1:80
iptables -t nat -A POSTROUTING -j MASQUERADE
service dnsmasq start
sleep 5
service dnsmasq restart
exit 0
