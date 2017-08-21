#!/bin/bash
clear
setfont gr928-8x16-thin.psfu
echo '--------------- Archon ----------------'
echo 'ο πρώτος Ελληνικός Arch Linux Installer'
echo
sleep 1
echo 
echo 'Έλεγχος σύνδεσης στο διαδίκτυο'
echo 
ping -c 5 www.google.com
if [ $? -eq 0 ]; then
  echo 'Υπάρχει σύνδεση στο διαδίκτυο'
  echo 'Η εγκατάσταση μπορεί να συνεχιστεί'
else
  echo 'Ελέξτε αν υπάρχει σύνδεση στο διαδίκτυο'
  exit	
fi

echo 
echo 'Διαλέξτε το δίσκο που θα γίνει η εγκατάσταση'
echo 
lsblk | grep -i sd
read -p "Σε ποιο δίσκο (/dev/sd?) θα εγκατασταθεί το Arch;" diskvar
echo
echo "Η εγκατάσταση θα γίνει στον" $diskvar
echo
echo 
echo 'Δημιουργία κατάτμησης'
echo  
SIZE=$(parted $diskvar print unit MB print free | grep -i "Disk /dev/sd " | head -n 1 | grep -oE "(\w+MB")
parted $diskvar mklabel gpt
parted $diskvar print
parted --align optimal $diskvar mkpart primary ext4 0% $SIZE
parted $diskvar print
mkfs.ext4 $diskvar
echo 
echo 'Προσάρτηση των Partition του Arch Linux'
echo 
mount $diskvar /mnt
echo 
echo 'Προσθήκη πηγών λογισμικού (Mirrors)'
echo 
pacman -Syy
pacman -S reflector
reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
echo 
echo 'Εγκατάσταση της Βάσης του Arch Linux'
echo 'Αν δεν έχετε κάνει ακόμα καφέ…. τώρα είναι η ευκαιρία...'
echo
sleep 2
pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
echo 
echo 'Είσοδος στο εγκατεστημένο Arch Linux'
echo 
arch-chroot /mnt
echo 
echo 'Τροποποίηση Γλώσσας και Ζώνης Ώρας'
echo 
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime
hwclock --systohc
echo
read -p "Δώστε όνομα υπολογιστή (hostname)" hostvar
echo $hostvar > /etc/hostname



