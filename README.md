# Linux-Minimal-Installation-and-Configuration
This repository is a guidance to install basic linux system on laptops or personal computers and configure it into a fully functioning operation system.

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

### Font Configuration

References
1. [Linux 桌面玩家指南：04. Linux 桌面系统字体配置要略](https://www.cnblogs.com/youxia/p/LinuxDesktop004.html)
2. [Linux下终极字体配置方案](https://ohmyarch.github.io/2017/01/15/Linux%E4%B8%8B%E7%BB%88%E6%9E%81%E5%AD%97%E4%BD%93%E9%85%8D%E7%BD%AE%E6%96%B9%E6%A1%88/)
3. [Linux字体美化实战(Fontconfig配置)](http://www.jinbuguo.com/gui/linux_fontconfig.html)