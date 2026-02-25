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
2. [Linux字体美化实战(Fontconfig配置)](http://www.jinbuguo.com/gui/linux_fontconfig.html)

### Chinese input method installation (for Sway/Wayland)

Install fcitx5 and Chinese input method addons:
```bash
sudo apt install --no-install-recommends fcitx5 fcitx5-config-qt fcitx5-frontend-all
sudo apt install fcitx5-chinese-addons
sudo apt install qt6-wayland
```

Run `fcitx5-config-qt` to configure input methods. Click the `+` button to add Chinese input methods (e.g., Pinyin).

The fcitx5 tray icon will appear in the waybar. Use `Ctrl+Space` (default) to toggle between English and Chinese input.

References
1. [Fcitx5 Chinese Input Setup on Ubuntu for Gaming](https://leimao.github.io/blog/Ubuntu-Gaming-Chinese-Input/)

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

## Dotfiles Setup

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage configuration files. Stow creates symlinks from your home directory to the config files in this repo, making it easy to version control and update your dotfiles.

### Install Stow

**Debian/Ubuntu:**
```bash
sudo apt install stow
```

**Arch Linux:**
```bash
sudo pacman -S stow
```

### Clone and Setup

```bash
# Clone the repository
git clone https://github.com/hellkonig/Linux-Minimal-Installation-and-Configuration.git ~/dotfiles
cd ~/dotfiles

# Stow all packages
stow -t ~ alacritty bash fcitx5 fontconfig gtk-3.0 gtk-4.0 nvim sway waybar wofi
```

### Available Packages

| Package | Description | Config Location |
|---------|-------------|-----------------|
| `alacritty` | Terminal emulator | `~/.config/alacritty/` |
| `bash` | Bash configuration | `~/.bashrc`, `~/.bash_profile` |
| `fcitx5` | Chinese input method (Sway) | `~/.config/sway/config.d/fcitx5.conf` |
| `fontconfig` | Font configuration | `~/.config/fontconfig/` |
| `gtk-3.0` | GTK3 theme settings | `~/.config/gtk-3.0/` |
| `gtk-4.0` | GTK4 theme settings | `~/.config/gtk-4.0/` |
| `nvim` | Neovim editor | `~/.config/nvim/` |
| `sway` | Wayland window manager | `~/.config/sway/` |
| `waybar` | Status bar for Wayland | `~/.config/waybar/` |
| `wofi` | Application launcher | `~/.config/wofi/` |

### Managing Packages

```bash
# Stow specific packages only
stow -t ~ fcitx5 sway waybar wofi

# Remove (unstow) a package
stow -t ~ -D alacritty

# Restow (refresh all links)
stow -t ~ -R sway

# Dry run (see what would happen without making changes)
stow -t ~ -n sway
```

### Important Notes

- **Backup:** If a config directory already exists (e.g., `~/.config/alacritty`), back it up first:
  ```bash
  mv ~/.config/alacritty ~/.config/alacritty.backup.$(date +%Y%m%d)
  ```
- **Target directory:** Always use `-t ~` to ensure symlinks are created in your home directory
- **Relative paths:** Stow uses relative paths, so your home directory can move between systems
