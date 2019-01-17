#!/bin/bash

./write-keys.sh
./download-from-objectstore.sh
./decrypt.sh
./upload-to-decos.sh
./upload-to-makkelijkemarkt.sh
./clean.sh
