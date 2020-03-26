#!/bin/bash

./write-keys.sh
./download-from-objectstore.sh
./decrypt.sh
./upload-to-makkelijkemarkt.sh
if [ "$FEATURE_UPLOAD_DECOS" == "1" ]; then
  ./upload-to-decos.sh
fi
./clean.sh
