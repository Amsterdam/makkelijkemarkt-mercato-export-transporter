#!/bin/sh
CONFIG_FILE="$HOME/.config/rclone/rclone.conf"
mkdir -p "$(dirname "$CONFIG_FILE")"

if [ ! -f "${CONFIG_FILE}" ]; then
  echo "Create config: ${CONFIG_FILE}"

cat > "$CONFIG_FILE" <<EOF
[denhaag]
type = azurefiles
account_name = ${DEN_HAAG_STORAGE_ACCOUNT_NAME}
share_name = fsdcopysweu02
connection_string = ${DEN_HAAG_SAS_TOKEN}

[amsterdam]
type = azureblob
env_auth = true
account = ${STORAGE_ACCOUNT_NAME}
EOF

fi

echo "Starting $*..."
exec "$@"
