#!/bin/sh
CONFIG_FILE="$HOME/.config/rclone/rclone.conf"
mkdir -p "$(dirname "$CONFIG_FILE")"

if [ ! -f "${CONFIG_FILE}" ]; then
  echo "Create config: ${CONFIG_FILE}"

cat > "$CONFIG_FILE" <<EOF
[denhaag]
type = azureblob
sas_url = ${DEN_HAAG_SAS_TOKEN}

[amsterdam]
type = azureblob
env_auth = true
account = ${STORAGE_ACCOUNT_NAME}
tenant = ${STORAGE_ACCOUNT_TENANT_ID}
EOF

fi

echo "Starting $*..."
exec "$@"