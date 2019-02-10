#!/bin/bash

./write-keys.sh
./download-from-objectstore.sh
./decrypt.sh
./upload-to-makkelijkemarkt.sh
./upload-to-decos.sh
./clean.sh
