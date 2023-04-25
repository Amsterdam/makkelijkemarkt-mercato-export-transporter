#!/bin/bash

echo ""
echo "=====> Start downloading from Mercato ObjectStore"

mkdir /tmp/download

swift \
  --auth-version 3 \
  --os-auth-url=$SWIFT_AUTH_URL \
  --os-region-name=$SWIFT_REGION \
  --os-username=$SWIFT_USER_NAME \
  --os-password=$SWIFT_USER_PASSWORD \
  --os-project-id=$SWIFT_PROJECT_ID \
  --os-project-domain-id=$SWIFT_DOMAIN_ID \
  download --output-dir=/tmp/download $MERCATO_CONTAINER

ls -larth /tmp/download

echo ""
