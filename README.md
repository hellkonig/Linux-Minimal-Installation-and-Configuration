# Arch-Installation-guide
This repository guide everybody to install arch linux on laptops or personal computers

## Pre installation

## Installation

## Post installation

### Configure your network (wired)
If you have a wired network connection, enter the following 
command.
```
ip link
```
to determine the interface name of your network adapter.

Replaceing interfacename in the following command with the name 
you retrieved 
```
systemctl enable dhcpcd@interfacename.service
```
to enable the ethernet connection.

### Configure your network (wireless) ###
If you have a wireless network, enter in the following commands
to enable it.
```
ip link
```
to determine the interface name of your network adapter.
```
pacman -S iw wpa_supplicant
```
to install the necessary software.
```
pacman -S dialog
```
to install the Wi-Fi menu.
```
pacman -S wpa_actiond
```
to install the software that allows you to automatically connect
to known networks.
```
systemctl enable netctl-auto@interfacename.service
```
to turn on the auto-connection service for your wireless adapter.

Next time you reboot, type
```
wifi-menu interfacename
```
to access the wireless menu for your adapter.
After you connect to the network for the first time, you will
be automatically connected for subsequent boots.

### Set the timezone

### Sync the time and date with Network Time Protocal 
Installed the required package
```
pacman -Syu ntp
```
Enable it at boot so every time you boot the system the clock will be synchronized
```
systemctl enable ntpd.service
```
Start it immediately
```
systemctl start ntpd.service
```

### Brightness Adjustment
If you install i3 as your window manager on your laptop, you probably find your screen is too bright and no way to change it. You have to call some intrinsic program to do it, like what I did:
```
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 400
```
You can run this command on your command line, or put it in one bash script so that you can run it repeatly without too many typing.
