#!/bin/bash
echo 'Archon'
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
fi

echo 
echo 'Διαλέξτε το δίσκο που θα γίνει η εγκατάσταση'
echo 
lsblk | grep -i sd


