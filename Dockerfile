# Use the Ubuntu 22 base image
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y curl unzip bash

# Download rclone and install
RUN curl -LO https://github.com/rclone/rclone/releases/download/v1.64.2/rclone-v1.64.2-linux-amd64.zip \
  && unzip rclone-v1.64.2-linux-amd64.zip \
  && cp rclone-v1.64.2-linux-amd64/rclone /usr/bin/ \
  && chmod +x /usr/bin/rclone

# Create a non-root user
RUN useradd -ms /bin/bash rclone

USER rclone

# Create the config directory
RUN mkdir -p /home/rclone/.config/rclone

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set the entrypoint command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["rclone"]
