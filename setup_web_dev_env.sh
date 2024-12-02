#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${GREEN}Starting web development environment setup...${NC}"

# Step 1: Update system and install basic utilities
echo -e "${GREEN}Updating system and installing basic utilities...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git build-essential software-properties-common apt-transport-https

# Step 2: Install Node.js and npm
echo -e "${GREEN}Installing Node.js and npm...${NC}"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "${GREEN}Node.js version: $(node -v)${NC}"
echo -e "${GREEN}npm version: $(npm -v)${NC}"

# Step 3: Install Visual Studio Code
echo -e "${GREEN}Installing Visual Studio Code...${NC}"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
echo -e "${GREEN}Visual Studio Code installed successfully.${NC}"

# Step 4: Install Visual Studio Code extensions
echo -e "${GREEN}Installing VS Code extensions...${NC}"
code --install-extension ms-vscode.vscode-typescript-next
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension eamodio.gitlens
code --install-extension formulahendry.auto-rename-tag
code --install-extension formulahendry.auto-close-tag
code --install-extension zhuangtongfa.material-theme
code --install-extension ritwickdey.LiveServer
echo -e "${GREEN}VS Code extensions installed.${NC}"

# Step 5: Install JetBrains Toolbox
echo -e "${GREEN}Installing JetBrains Toolbox...${NC}"
JETBRAINS_TOOLBOX_URL="https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.27.2.13801.tar.gz"
wget -q $JETBRAINS_TOOLBOX_URL -O jetbrains-toolbox.tar.gz
tar -xzf jetbrains-toolbox.tar.gz
cd jetbrains-toolbox-*
./jetbrains-toolbox
cd ..
rm -rf jetbrains-toolbox*
echo -e "${GREEN}JetBrains Toolbox installed. Use it to install IntelliJ IDEA, WebStorm, etc.${NC}"

# Step 6: Install Chrome and Chrome DevTools
echo -e "${GREEN}Installing Google Chrome...${NC}"
wget -qO- https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable
echo -e "${GREEN}Google Chrome and Chrome DevTools installed.${NC}"

# Step 7: Install Postman
echo -e "${GREEN}Installing Postman...${NC}"
sudo snap install postman
echo -e "${GREEN}Postman installed.${NC}"

# Step 8: Install Docker (for backend debugging)
echo -e "${GREEN}Installing Docker...${NC}"
sudo apt install -y docker.io
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
echo -e "${GREEN}Docker installed. Restart your system to apply group changes.${NC}"

# Step 9: Install Debugging Tools (optional)
echo -e "${GREEN}Installing additional debugging tools...${NC}"
sudo apt install -y curl jq httpie
npm install -g @vue/cli create-react-app eslint prettier
echo -e "${GREEN}Debugging tools installed.${NC}"

# Cleanup
rm -f packages.microsoft.gpg

echo -e "${GREEN}Web development environment setup complete!${NC}"
echo -e "${GREEN}You can start using VS Code, JetBrains Toolbox, Postman, Docker, and other tools for development.${NC}"
