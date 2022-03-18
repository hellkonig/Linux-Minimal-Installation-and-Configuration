# Linux-Minimal-Installation-and-Configuration
This repository is a guidance to install basic linux system on laptops or personal computers and configure it into a fully functioning operation system.

## Pre installation

Reference
1. [Ubuntu UEFI Minimal Install](https://www.kgoettler.com/post/ubuntu-minimal/)
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

### Chinese input method installation

We would need to install `fcitx` and `fcitx-googlepinyin` first.
```
# Install fcitx input method system
$ sudo apt install fcitx-bin
# Install Google Pinyin Chinese input method
$ sudo apt install fcitx-googlepinyin
```

Run `im-config` and change the input method to `fcitx`, reboot the server.

Run `fcitx-configtool` after login, click `+` button to add new input method. In the popup selection box uncheck “Only Show Current Language” and then search for “google” to add Google Pinyin”.

In `Global Config` tab, choose the shortcut keys for switching input methods and also add Google Pinyin input method.

References
1. [Install Google Pinyin input method on Ubuntu/Debian](https://mrzhubin.wordpress.com/2019/09/20/install-google-pinyin-input-method-on-debian/)
2. [Fcitx Chinese Input Setup on Ubuntu for Gaming](https://leimao.github.io/blog/Ubuntu-Gaming-Chinese-Input/)

### Swap Ctrl and Caps Lock

Caps Lock key is one of the best positioned keys in the keyboards, but it is seldom utilized. While Ctrl is often utilized for Linux command line and some popular editors, it is best to swap these two keys to make life easy.

A simple way is using `xmodmap`. You need to create a text file  (e.g. you can name it as `.Xmodmap`) and put the following lines in the file:
```
!Swap Caps Lock with the Left Control key
remove Lock = Caps_Lock
remove Control = Control_L
keysym Caps_Lock = Control_L
keysym Control_L = Caps_Lock
add Lock = Caps_Lock
add Control = Control_L
```
After this we just need to run the following to apply the changes:
```
xmodmap ~/.Xmodmap
```

The problem for the method above is you have to run the command every time you start your computer or you plug in your keyboard. 
A fundamental way to swap Ctrl and Caps Lock is swaping the keycodes, that are emitted by those buttons. In the file `/usr/share/X11/xkb/keycodes/evdev`, find and modify the two lines:
```
<CAPS> = 37; //66;
<LCTL> = 66; //37;
```
You also need to log off from the window manager (X window system) to apply the changes.

References
1. [Making better use of the Caps Lock key in Linux](https://www.jveweb.net/en/archives/2010/11/making-better-use-of-the-caps-lock-key-in-linux.html)
2. [Keycodes swap](https://askubuntu.com/a/1006087)