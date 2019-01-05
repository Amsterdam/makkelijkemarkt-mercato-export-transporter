#!/bin/bash

echo ""
echo "=====> Writing keys from enviroment to files"

mkdir /keys

echo "$GPG_PRIVATE_BASE64" | base64 -d > /keys/private.gpg
echo "$GPG_PUBLIC_BASE64" | base64 -d > /keys/public.asc

ls -larth /keys

echo ""
