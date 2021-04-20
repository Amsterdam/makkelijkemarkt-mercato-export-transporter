#!/bin/bash

echo ""
echo "=====> Upload to MakkelijkeMarkt"

echo "Switch workdir to /tmp/download"
cd /tmp/download



for file in *
do
  swift \
    --auth-version 3 \
    --os-auth-url=$SWIFT_AUTH_URL \
    --os-region-name=$SWIFT_REGION \
    --os-username=$DST_SWIFT_USER_NAME \
    --os-password=$DST_SWIFT_USER_PASSWORD \
    --os-project-id=$DST_SWIFT_PROJECT_ID \
    --os-project-domain-id=$SWIFT_DOMAIN_ID \
    upload $MAKKELIJKEMARKT_CONTAINER $file
done

echo "Switch workdir back"
cd -

echo "Upload done, listing files in container"
swift \
  --auth-version 3 \
  --os-auth-url=$SWIFT_AUTH_URL \
  --os-region-name=$SWIFT_REGION \
  --os-username=$DST_SWIFT_USER_NAME \
  --os-password=$DST_SWIFT_USER_PASSWORD \
  --os-project-id=$DST_SWIFT_PROJECT_ID \
  --os-project-domain-id=$SWIFT_DOMAIN_ID \
  list $MAKKELIJKEMARKT_CONTAINER

echo ""
