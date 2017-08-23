#!/bin/bash
clear
setfont gr928-8x16-thin.psfu
echo '--------------- Archon ----------------'
echo 'ο πρώτος Ελληνικός Arch Linux Installer'
echo '---------------------------------------'
sleep 2
echo '---------------------------------------'
echo 'Έλεγχος σύνδεσης στο διαδίκτυο'
echo '---------------------------------------'
ping -c 5 www.google.com
if [ $? -eq 0 ]; then
  echo '---------------------------------------'
  echo 'Υπάρχει σύνδεση στο διαδίκτυο'
  echo 'Η εγκατάσταση μπορεί να συνεχιστεί'
  echo '---------------------------------------'
else
  echo 'Ελέξτε αν υπάρχει σύνδεση στο διαδίκτυο'
  exit	
fi

echo '--------------------------------------------'
echo 'Διαλέξτε το δίσκο που θα γίνει η εγκατάσταση'
echo '--------------------------------------------'
lsblk | grep -i sd
echo '--------------------------------------------------------'
read -p "Σε ποιο δίσκο (/dev/sd?) θα εγκατασταθεί το Arch;" diskvar
echo '--------------------------------------------------------'
echo
echo '--------------------------------------------------------'
echo "Η εγκατάσταση θα γίνει στον" $diskvar
echo '--------------------------------------------------------'
echo
sleep 2
echo 
echo 'Δημιουργία κατάτμησης'
echo  
parted $diskvar mklabel gpt
parted $diskvar mkpart primary ext4 1MiB 100%
mkfs.ext4 $diskvar
echo 
echo '--------------------------------------------------------'
echo 'Προσάρτηση των Partition του Arch Linux'
echo '--------------------------------------------------------'
echo 
sleep 1
mount $diskvar /mnt
echo 
echo '--------------------------------------------------------'
echo 'Προσθήκη πηγών λογισμικού (Mirrors)'
echo '--------------------------------------------------------'
echo
sleep 1 
pacman -Syy
pacman -S reflector
reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
echo 
echo '--------------------------------------------------------'
echo 'Εγκατάσταση της Βάσης του Arch Linux'
echo 'Αν δεν έχετε κάνει ακόμα καφέ…. τώρα είναι η ευκαιρία...'
echo '--------------------------------------------------------'
echo
sleep 2
pacstrap -i /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab
echo 
echo '--------------------------------------------------------'
echo 'Είσοδος στο εγκατεστημένο Arch Linux'
echo '--------------------------------------------------------'
echo
wget https://raw.githubusercontent.com/billniakas/archon/master/archon.2 
cp archon.2 /mnt/root/archon.sh
arch-chroot /mnt && sh archon.sh



