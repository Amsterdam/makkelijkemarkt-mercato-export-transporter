#!/bin/bash

echo ""
echo "=====> Decrypt"

export GPG_TTY=$(tty)

echo "GPG version"
gpg --version

echo "Importing public key"
gpg --batch --import /keys/public.asc

echo "Importing private key"
gpg --batch --import /keys/private.gpg

echo "List public keys"
gpg --list-keys

echo "List private keys"
gpg --list-secret-keys

echo "Decrypt *.gpg files in directory"
gpg --batch --decrypt-files /tmp/download/*.gpg 

echo "List all files after decrypting"
ls -larth /tmp/download

#echo "Show contents of test file..."
#cat /tmp/download/test2.txt

echo ""
