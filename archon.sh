#!/bin/bash
clear
setfont gr928-8x16-thin.psfu
echo '---------------------- Archon -------------------------'
echo 
echo 
echo  .d888888                    dP                         
echo  d8'    88                    88                         
echo  88aaaaa88a 88d888b. .d8888b. 88d888b. .d8888b. 88d888b. 
echo  88     88  88'  `88 88'  `"" 88'  `88 88'  `88 88'  `88 
echo  88     88  88       88.  ... 88    88 88.  .88 88    88 
echo  88     88  dP       `88888P' dP    dP `88888P' dP    dP 
echo  oooooooooooooooooooooooooooooooooooooooooooooooooooooooo
echo          Ο πρώτος Ελληνικός Arch Linux Installer
echo '--------------------------------------------------------'                                                        
sleep 2
echo ' Σκοπός αυτού του cli εγκαταστάτη είναι η εγκατάσταση του'
echo ' βασικού συστήματος Arch Linux ΧΩΡΙΣ γραφικό περιβάλλον.'
echo ' Προτείνεται η εγκατάσταση σε ξεχωριστό δίσκο για την '
echo ' αποφυγή σπασίματος του συστήματος σας. Το script αυτό '
echo ' παρέχεται χωρίς καμιάς μορφής εγγύηση σωστής λειτουργίας.'
echo ' You have been warned !!!'
sleep 5
echo '---------------------------------------'
echo ' Έλεγχος σύνδεσης στο διαδίκτυο'
echo '---------------------------------------'
ping -c 5 www.google.com
if [ $? -eq 0 ]; then
  echo '---------------------------------------'
  echo ' Υπάρχει σύνδεση στο διαδίκτυο'
  echo ' Η εγκατάσταση μπορεί να συνεχιστεί'
  echo '---------------------------------------'
else
  echo 'Ελέξτε αν υπάρχει σύνδεση στο διαδίκτυο'
  exit	
fi

echo '---------------------------------------------'
echo ' Διαλέξτε το δίσκο που θα γίνει η εγκατάσταση'
echo '---------------------------------------------'
lsblk | grep -i sd
echo '--------------------------------------------------------'
read -p " Σε ποιο δίσκο (/dev/sd?) θα εγκατασταθεί το Arch;" diskvar
echo '--------------------------------------------------------'
echo
echo '--------------------------------------------------------'
echo " Η εγκατάσταση θα γίνει στον" $diskvar
echo '--------------------------------------------------------'
echo
sleep 2
echo 
echo '--------------------------------------------------------'
echo ' Δημιουργία κατάτμησης'
echo '--------------------------------------------------------'
echo  
parted $diskvar mklabel msdos
parted $diskvar mkpart primary ext4 1MiB 100%
mkfs.ext4 $diskvar"1"
echo 
echo '--------------------------------------------------------'
echo ' Προσάρτηση των Partition του Arch Linux'
echo '--------------------------------------------------------'
echo 
sleep 1
mount $diskvar"1" /mnt
echo 
echo '--------------------------------------------------------'
echo ' Προσθήκη πηγών λογισμικού (Mirrors)'
echo '--------------------------------------------------------'
echo
sleep 1 
pacman -Syy
pacman -S --noconfirm reflector
reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy
echo 
echo '--------------------------------------------------------'
echo ' Εγκατάσταση της Βάσης του Arch Linux'
echo ' Αν δεν έχετε κάνει ακόμα καφέ…. τώρα είναι η ευκαιρία...'
echo '--------------------------------------------------------'
echo
sleep 2
pacstrap -i /mnt base base-devel
echo 
echo '--------------------------------------------------------'
echo ' Είσοδος στο εγκατεστημένο Arch Linux'
echo '--------------------------------------------------------'
echo
wget https://raw.githubusercontent.com/billniakas/archon/master/archon.2 
chmod +x archon.2
cp archon.2 /mnt/archon2.sh
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ./archon2.sh
echo
echo '--------------------------------------------------------'
echo ' Τέλος εγκατάστασης'
echo ' Το σύστημα θα επανεκκινήσει σε 5 δευτερόλεπτα '
echo '--------------------------------------------------------'
sleep 5
reboot




