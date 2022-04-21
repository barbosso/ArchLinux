#!/bin/bash

# Arch Linux Fast Install - Быстрая установка Arch Linux https://github.com/ordanax/arch
# Цель скрипта - быстрое развертывание системы с вашими персональными настройками (конфиг XFCE, темы, программы и т.д.).
# Автор скрипта Алексей Бойко https://vk.com/ordanax


loadkeys ru
setfont cyr-sun16
echo 'Скрипт сделан на основе чеклиста Бойко Алексея по Установке ArchLinux'
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4.2 Форматирование дисков'

mkfs.fat -F32 /dev/sda1
mkfs.ext4  /dev/sda2
# mkfs.ext4  /dev/sdc3

echo '2.4.3 Монтирование дисков'
mount /dev/sda2 /mnt
# mkdir /mnt/home
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
# mount /dev/sdc3 /mnt/home

echo '3.1 Выбор зеркал для загрузки.'
rm -rf /etc/pacman.d/mirrorlist
curl https://raw.githubusercontent.com/barbosso/arch/master/mirrorlist -o mirrorlist
mv -f ~/mirrorlist /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd netctl zsh terminus-font wget

echo '3.3 Настройка системы'
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/barbosso/arch/master/archuefi2.sh)"
