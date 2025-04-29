#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# Install MATE desktop environment core
echo "Installing MATE desktop environment core..."
sudo apt-get install mate-desktop-environment-core -y

# Download Chrome Remote Desktop
echo "Downloading Chrome Remote Desktop..."
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

# Install Chrome Remote Desktop
echo "Installing Chrome Remote Desktop..."
sudo apt install ./chrome-remote-desktop_current_amd64.deb -y


echo "All installations are complete!"
