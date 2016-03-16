# Arch-Installation-guide
This repository guide everybody to install arch linux on laptops or personal computers

## Pre installation

## Installation

## Post installation

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
