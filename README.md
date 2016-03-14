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
