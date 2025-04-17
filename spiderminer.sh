#!/bin/bash

# Display the initial text
echo "
  _____       _     _           __  __ _                  
 / ____|     (_)   | |         |  \/  (_)                 
| (___  _ __  _  __| | ___ _ __| \  / |_ _ __   ___ _ __  
 \___ \| '_ \| |/ _\` |/ _ \ '__| |\/| | | '_ \ / _ \ '__| 
 ____) | |_) | | (_| |  __/ |  | |  | | | | | |  __/ |    
|_____/| .__/|_|\__,_|\___|_|  |_|  |_|_|_| |_|\___|_|    
       | |                                                 
       |_|                                                 
Miner
"

# Ask to start mining
read -p "Do you want to start mining? (y/n) " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Mining cancelled."
    exit 0
fi

# Install sudo if not already installed
echo "Installing sudo..."
apt install sudo -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

# Clone the xmrig repository
echo "Cloning xmrig repository..."
git clone https://github.com/xmrig/xmrig.git

# Change directory to xmrig
cd xmrig

# Create build directory
mkdir -p build

# Change directory to build
cd build

# Run cmake
cmake ..

# Compile with all available processors
make -j$(nproc)

echo "Build process completed!"
echo "You are now in the $(pwd) directory"
exec bash  # This keeps the user in the xmrig/build directory after script exits
