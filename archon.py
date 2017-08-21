import sys
import subprocess
import os
import time

print(subprocess.getoutput("setfont gr928-8x16-thin.psfu"))
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
    disk = input("Δώσε το δίσκο όπου θα γίνει η εγκατάσταση : ")
    if disk == "":
        quit()
    device = "/dev/"+disk
    print("To Arch θα εγκατασταθει στον {}".format(device))
    return device

def disk_part()
    size = print(subprocess.getoutput("sudo parted"+device+"print unit MB print free | grep -i '''Disk /dev/sd ''' | head -n 1 | grep -oE '''(\w+MB)'''"))
    

def mount_disk():
    print(subprocess.getoutput("mount"+device+"/mnt"))


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
    print(subprocess.getoutput("arch-chroot /mnt"))


def locale():
    print(subprocess.getoutput('''echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen'''))
    print(subprocess.getoutput("locale-gen"))
    print(subprocess.getoutput("echo LANG=en_US.UTF-8 > /etc/locale.conf"))
    print(subprocess.getoutput("export LANG=en_US.UTF-8"))
    print(subprocess.getoutput("ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime"))
    print(subprocess.getoutput("hwclock --systohc"))

def hostname():
    hostname = input("Δώσε όνομα υπολογιστή(hostname) : ")
    print(subprocess.getoutput("echo"+hostname+"> /etc/hostname"))

        
    



while True:
    disk_check()
    disk_part()
    
