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

# Install Firefox
echo "Installing Firefox..."
sudo apt install firefox -y

# Additional installations
echo "Installing software-properties-common..."
sudo apt-get install software-properties-common -y

echo "Adding Mozilla PPA repository..."
sudo add-apt-repository ppa:mozillateam/ppa -y

echo "Updating package list again..."
sudo apt-get update

echo "Installing Firefox ESR..."
sudo apt-get install firefox-esr -y

echo "Adding Opera browser repository..."
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'

echo "Adding Opera GPG key..."
sudo sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'

echo "Updating package list again..."
sudo apt-get update

echo "Installing Opera browser..."
sudo apt-get install opera -y

echo "All installations are complete!"
