#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Animation function
function animate() {
    local chars="/-\|"
    while :; do
        for (( i=0; i<${#chars}; i++ )); do
            sleep 0.1
            echo -en "${BLUE}${chars:$i:1}${NC}" "\r"
        done
    done
}

# Display the cool ASCII art with colors
echo -e "${PURPLE}
  _____       _     _           __  __ _                  
 / ____|     (_)   | |         |  \/  (_)                 
| (___  _ __  _  __| | ___ _ __| \  / |_ _ __   ___ _ __  
 \___ \| '_ \| |/ _\` |/ _ \ '__| |\/| | | '_ \ / _ \ '__| 
 ____) | |_) | | (_| |  __/ |  | |  | | | | | |  __/ |    
|_____/| .__/|_|\__,_|\___|_|  |_|  |_|_|_| |_|\___|_|    
       | |                                                 
       |_|${RED}                                                 
   __  __ _                                                  
  / / / (_)                                                 
 / / / / _ _ __   ___ _ __                                  
/ /_/ / | | '_ \ / _ \ '__|                                 
\____/|_|_| | | |  __/ |                                    
            |_| |_|\___|_|                                 
${NC}"

# Ask to start mining with colorful prompt
echo -e "${YELLOW}🚀 Welcome to XMRig Miner Setup! 🚀${NC}"
read -p "$(echo -e ${CYAN}"Do you want to start mining? (y/n) "${NC})" answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo -e "${RED}❌ Mining cancelled.${NC}"
    exit 0
fi

# Start animation in background
animate &
ANIMATE_PID=$!
disown

# Install sudo if not already installed
echo -e "\n${GREEN}🔧 Installing sudo...${NC}"
apt install sudo -y > /dev/null 2>&1

# Install required dependencies
echo -e "${GREEN}📦 Installing dependencies...${NC}"
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y > /dev/null 2>&1

# Clone the xmrig repository
echo -e "${GREEN}📥 Cloning xmrig repository...${NC}"
git clone https://github.com/xmrig/xmrig.git > /dev/null 2>&1

# Change directory to xmrig
cd xmrig

# Create build directory
echo -e "${GREEN}🛠️  Creating build directory...${NC}"
mkdir -p build

# Change directory to build
cd build

# Run cmake
echo -e "${GREEN}⚙️  Running cmake...${NC}"
cmake .. > /dev/null 2>&1

# Compile with all available processors
echo -e "${GREEN}🔨 Compiling xmrig (this may take a while)...${NC}"
make -j$(nproc) > /dev/null 2>&1

# Kill the animation
kill $ANIMATE_PID > /dev/null 2>&1

echo -e "\n${GREEN}🎉 Build process completed!${NC}"
echo -e "${BLUE}💻 You are now in the $(pwd) directory${NC}"
echo -e "${YELLOW}💰 Now Send Your Xmrig Token${NC}"

# Create a cool prompt
PS1="\[\e[1;35m\]XMRig\[\e[1;36m\]@\[\e[1;34m\]Miner \[\e[1;33m\]\w\[\e[1;31m\] # \[\e[0m\]"
export PS1

exec bash
