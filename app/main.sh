#!/bin/bash

ENVIRONMENT=$1

print_help() {
  echo "Usage: $0 [acceptance|production]"
  echo "When running 'acceptance', the upload to Decos is disabled"
  exit 1
}

if [ -z $ENVIRONMENT ]; then
  print_help
fi
if [ "$ENVIRONMENT" != "acceptance" ] && [ "$ENVIRONMENT" != "production" ]; then
  print_help
fi

echo "Running script for environment '$ENVIRONMENT'"

./write-keys.sh
./download-from-objectstore.sh
./decrypt.sh
./upload-to-makkelijkemarkt.sh
if [ "$ENVIRONMENT" == "production" ]; then
  ./upload-to-decos.sh
fi
./clean.sh
