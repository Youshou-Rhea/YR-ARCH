#!/bin/bash

hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync acpi acpi_call edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid ntfs-3g terminus-font nano

#Uncomment one of the lines below depending on your graphics card. If you have intel, you can safely ignore it.
# pacman -S --noconfirm mesa lib32-mesa #Older Intel Cards
# pacman -S --noconfirm mesa lib32-mesa vulkan-intel #ivylake and newer
pacman -S --noconfirm xf86-video-amdgpu mesa lib32-mesa lib32-vulkan-radeon vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

useradd -m YOUR USERNAME
echo YOUR USERNAME:password | chpasswd

echo "YOUR USERNAME ALL=(ALL) ALL" >> /etc/sudoers.d/"YOUR USERNAME"


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
