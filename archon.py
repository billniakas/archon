import sys
import subprocess
import os
import time


print("Archon - ο πρώτος ελληνικός Arch Linux Installer")

def ping_check():
    print("\nΈλεγχος σύνδεσης στο διαδίκτυο\n")
    try:
        print(subprocess.getoutput("ping -c 5 www.google.com"))
        print("\nΕπιτυχής έλεγχος")
    except:
        print("Δεν υπάρχει σύνδεση στο διαδίκτυο\nη εγκατάσταση δεν μπορεί να συνεχιστεί")
        quit()  


def disk_check():
    print(subprocess.getoutput("lsblk | grep -i sd"))



def add_mirrors():
    print(subprocess.getoutput("pacman -Syy"))
    print(subprocess.getoutput("pacman -S reflector"))
    print(subprocess.getoutput("reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"))
    print(subprocess.getoutput("pacman -Syy"))


def install_arch():
    print("Έναρξη εγκατάστασης βασικού συστήματος\n")
    time.sleep(1)
    print(subprocess.getoutput("pacstrap -i /mnt base base-devel"))
    print(subprocess.getoutput("genfstab -U /mnt >> /mnt/etc/fstab"))

    
    


