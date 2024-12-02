#!/bin/bash

# Exit on error
set -e

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${GREEN}Starting Android development environment setup...${NC}"

# Step 1: Update the system
echo -e "${GREEN}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget unzip git build-essential apt-transport-https software-properties-common

# Step 2: Install Android Studio
echo -e "${GREEN}Installing Android Studio...${NC}"
sudo add-apt-repository -y ppa:maarten-fonville/android-studio
sudo apt update
sudo apt install -y android-studio
echo -e "${GREEN}Android Studio installed successfully.${NC}"

# Step 3: Install Android SDK Command-line Tools
echo -e "${GREEN}Installing Android SDK Command-line Tools...${NC}"
ANDROID_SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"
SDK_DIR="$HOME/Android/Sdk"
mkdir -p "$SDK_DIR/cmdline-tools"
wget -q $ANDROID_SDK_URL -O cmdline-tools.zip
unzip -q cmdline-tools.zip -d "$SDK_DIR/cmdline-tools"
mv "$SDK_DIR/cmdline-tools/cmdline-tools" "$SDK_DIR/cmdline-tools/latest"
rm cmdline-tools.zip
echo "export ANDROID_HOME=$SDK_DIR" >> ~/.bashrc
echo "export PATH=\$ANDROID_HOME/cmdline-tools/latest/bin:\$PATH" >> ~/.bashrc
echo "export PATH=\$ANDROID_HOME/platform-tools:\$PATH" >> ~/.bashrc
source ~/.bashrc
echo -e "${GREEN}Android SDK Command-line Tools installed.${NC}"

# Step 4: Install Java (required for Android Studio and SDK)
echo -e "${GREEN}Installing OpenJDK 17...${NC}"
sudo apt install -y openjdk-17-jdk
echo -e "${GREEN}Java version: $(java -version)${NC}"

# Step 5: Install Kotlin Compiler
echo -e "${GREEN}Installing Kotlin Compiler...${NC}"
sudo snap install kotlin --classic
echo -e "${GREEN}Kotlin Compiler installed.${NC}"

# Step 6: Install Additional Compilers and Tools
echo -e "${GREEN}Installing various programming language compilers and tools...${NC}"
# C/C++
sudo apt install -y gcc g++ clang
# Python
sudo apt install -y python3 python3-pip
# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
# Go
wget -q https://go.dev/dl/go1.21.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
rm go1.21.1.linux-amd64.tar.gz
echo "export PATH=/usr/local/go/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
# Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "${GREEN}Compilers and tools installed.${NC}"

# Step 7: Install Code Snippet Tools
echo -e "${GREEN}Installing code snippet tools...${NC}"
sudo snap install code --classic
code --install-extension ms-vscode.sublime-keybindings
code --install-extension formulahendry.code-runner
echo -e "${GREEN}VS Code and snippet tools installed.${NC}"

# Step 8: Install Themes for Android Studio and VS Code
echo -e "${GREEN}Installing themes for Android Studio and VS Code...${NC}"
# Android Studio Themes (Material Theme)
wget -q https://plugins.jetbrains.com/files/8006/197503/material-theme-ui.zip -O material-theme.zip
unzip -q material-theme.zip -d "$HOME/.local/share/JetBrains"
rm material-theme.zip
# VS Code Themes
code --install-extension zhuangtongfa.material-theme
echo -e "${GREEN}Themes installed.${NC}"

# Step 9: Cleanup
echo -e "${GREEN}Cleaning up...${NC}"
sudo apt autoremove -y

echo -e "${GREEN}Android development environment setup complete!${NC}"
echo -e "${GREEN}You can start using Android Studio, the Android SDK, and various programming tools.${NC}"
