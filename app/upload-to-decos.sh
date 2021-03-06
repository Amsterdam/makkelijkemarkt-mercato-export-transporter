#!/bin/bash

echo ""
echo "=====> Upload to Decos"

mkdir /tmp/decos
unzip /tmp/download/Bestanden.zip -d /tmp/decos

ls -larth /tmp/decos

echo "$BRIEVENBUS_USERNAME - $BRIEVENBUS_PASSWORD - $BRIEVENBUS_SERVER - $BRIEVENBUS_PORT" | base64

sshpass -p "$BRIEVENBUS_PASSWORD" sftp -v -oStrictHostKeyChecking=no -oBatchMode=no -o User=$BRIEVENBUS_USERNAME -oPort=$BRIEVENBUS_PORT -b - $BRIEVENBUS_SERVER << !
   put /tmp/decos/Decos_Koopman.CSV
   bye
!

echo ""
