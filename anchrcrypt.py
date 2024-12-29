#!/usr/bin/env python3

import os
import sys
from cryptography.fernet import Fernet
# Encrypt files
def decrypt(file):
    files = []

    
    files.append(file)

    
    with open("thekey.key", "rb") as key_file:
        secretkey = key_file.read()

    # Decrypting files
    for file in files:
        with open(file, "rb") as thefile:
            contents = thefile.read()
            contents_decrypted = Fernet(secretkey).decrypt(contents)

        with open(file, "wb") as myfile:
            myfile.write(contents_decrypted)
            print(f"File {file} decrypted successfully!")

# Encrypt files
def encrypt(file):
    files = []

    
    files.append(file)

    
    key = Fernet.generate_key()
    with open("thekey.key", "wb") as key_file:
        key_file.write(key)

    
    for file in files:
        with open(file, "rb") as thefile:
            contents = thefile.read()
            contents_encrypted = Fernet(key).encrypt(contents)

        with open(file, "wb") as myfile:
            myfile.write(contents_encrypted)
            print(f"File {file} encrypted successfully!")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python anchrcrypt.py [-e|-d] <filename>")
        sys.exit(1)

    mode = sys.argv[1]
    file = sys.argv[2]

    if mode == "-e":
        encrypt(file)
    elif mode == "-d":
        decrypt(file)
    else:
        print("Invalid option. Use -e to encrypt or -d to decrypt.")
