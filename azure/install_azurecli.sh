#!/bin/bash

# Install and Patch Azure CLI on Kali Linux

# modify as needed
DEBIAN_VERSION='bullseye'

# install azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo DIST_CODE=$DEBIAN_VERSION bash

# create this file
sudo touch /etc/apt/preferences.d/azure-cli.pref

# tell debian to prefer microsoft's azure cli
cat > '/etc/apt/preferences.d/azure-cli.pref' <<EOF
Package: *
Pin: Release o=azure-cli bullseye
Pin-Priority: 600
EOF

# downgrade to use microsoft's azure cli
sudo apt install azure-cli=2.36.0-1~bullseye --allow-downgrades -y
