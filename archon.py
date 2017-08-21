import sys
import subprocess
import os


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

disk_check()
