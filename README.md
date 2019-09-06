# ComPineHarvester

# A fake credential harvesting rogue captive portal for Raspberry Pi 3 / 3 B+

Installation after a fresh install of Kali Linux ARM 64-bit:
	
```
sudo apt-get install git php dnsmasq macchanger
git clone https://github.com/NickJongens/ComPineHarvester
cd ComPineHarvester
chmod +x install.sh
sudo ./install.sh
sudo reboot
```
During installation, macchanger will ask whether or not MAC addresses should be changed automatically - choose "No". The startup script in rc.local will perform this task more reliably.

After reboot, look for an access point named "Google Free WiFi." Connecting to it from an Apple, Android or Windows device should automatically bring up a captive portal login screen.
The Windows captive portal is a bit harder to introduce properly. 
It requires a folder called 'redirect' with it's own 'index.html' file redirecting to the root website index.html

Credentials are logged in `/var/www/html/usernames.txt`.

I do NOT take any responsibility for your actions while using any material provided from this repository.
Performing attacks on public users is illegal and should require permission from all users within the radius of the network.
