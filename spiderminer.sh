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

# Spider-themed ASCII art
echo -e "${RED}
   _____       _       _             _____ _             
  / ____|     (_)     | |           |  __ (_)            
 | (___  _ __  _ _ __ | |_ ___ _ __ | |__) _ _ __   ___  
  \___ \| '_ \| | '_ \| __/ _ \ '_ \|  ___| | '_ \ / _ \ 
  ____) | |_) | | | | | ||  __/ | | | |   | | | | |  __/ 
 |_____/| .__/|_|_| |_|\__\___|_| |_|_|   |_|_| |_|\___| 
        | |                                              
        |_|                                              
  _____ _           _   _                               
 / ____| |         | | (_)                              
| (___ | |__   ___ | |_ _ _ __   __ _                   
 \___ \| '_ \ / _ \| __| | '_ \ / _\` |                  
 ____) | | | | (_) | |_| | | | | (_| |                  
|_____/|_| |_|\___/ \__|_|_| |_|\__, |                  
                                  __/ |                  
                                 |___/                   
${NC}"

# Ask to start mining with colorful prompt
echo -e "${YELLOW}🕷️ Welcome to ${RED}Spider Miner${YELLOW} Setup! 🕷️${NC}"
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

# Clone the xmrig repository (but we'll brand it as Spider Miner)
echo -e "${GREEN}📥 Downloading ${RED}Spider Miner${GREEN} engine...${NC}"
git clone https://github.com/xmrig/xmrig.git > /dev/null 2>&1

# Change directory to xmrig (we'll refer to it as Spider Miner)
cd xmrig

# Create build directory
echo -e "${GREEN}🛠️  Building ${RED}Spider Miner${GREEN}...${NC}"
mkdir -p build

# Change directory to build
cd build

# Run cmake
echo -e "${GREEN}⚙️  Configuring ${RED}Spider Miner${GREEN}...${NC}"
cmake .. > /dev/null 2>&1

# Compile with all available processors
echo -e "${GREEN}🔨 Compiling ${RED}Spider Miner${GREEN} (this may take a while)...${NC}"
make -j$(nproc) > /dev/null 2>&1

# Kill the animation
kill $ANIMATE_PID > /dev/null 2>&1

echo -e "\n${GREEN}🎉 ${RED}Spider Miner${GREEN} build completed!${NC}"
echo -e "${BLUE}💻 You are now in the $(pwd) directory${NC}"
echo -e "${YELLOW}💰 Now enter your ${RED}Spider Miner${YELLOW} configuration${NC}"

# Create a spider-themed prompt
PS1="\[\e[1;31m\]🕷️ Spider\[\e[1;33m\]Miner \[\e[1;36m\]\w\[\e[1;35m\] > \[\e[0m\]"
export PS1

exec bash
