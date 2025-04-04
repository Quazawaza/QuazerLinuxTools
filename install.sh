#!/bin/bash
# This script installs Package of useful tools for Linux

# Check if the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (using sudo)."
    exit 1
fi

function header()
{
    clear
    echo "========================================================"
    echo "  Package of useful tools for Linux"
    echo "  by Quazer"
    echo "  Version: 1.0"
    echo "========================================================"
    echo
}

# essential packages

ESSENTIAL_PACKAGES=(
    "git"
    "curl"
    "wget"
    "nano"
    "htop"
    "tree"
    "net-tools"
    "build-essential"
    "python3"
    "python3-venv"
    "python3-pip"
    "gdb"
    "neofetch"
    "tmux"
    "zsh"
)

# Rust installation
function install_rust() {
    if command -v rustc &> /dev/null; then
        echo "Rust is already installed."
    else
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        echo "Rust installed successfully."
    fi
}

#Java installation
function install_java() {
    echo "Installing Java..."
    sudo apt install default-jdk -y
    echo "Java installed successfully."
}

# network tools
NETWORK_TOOLS=(
    "nmap"
    "wireshark"
    "netcat"
    "aircrack-ng"
    "wifite"
    "macchanger"
    "wireguard"
    "hping3"
    "tcpflow"
    "ettercap"
    "hashcat"
    "john"
    "binwalk"
    "tcpdump"
    "dnsutils"
)

#install AngryOxide

function install_angryoxide() {
    if command -v angryoxide &> /dev/null; then
        echo "AngryOxide is already installed."
    else
        echo "Installing AngryOxide..."
        git clone --recurse-submodules https://github.com/Ragnt/AngryOxide.git
        cd AngryOxide
        make
        sudo make install
        cd ..
        rm -rf AngryOxide
        echo "AngryOxide installed successfully."
    fi
}

# install AngryIP

function install_angryIPscanner() {
    if command -v ipscan &> /dev/null; then
        echo "AngryIPScanner is already installed."
    else
        echo "Installing AngryIP..."
        wget https://github.com/angryip/ipscan/releases/download/3.9.1/ipscan_3.9.1_amd64.deb
        sudo dpkg -i ipscan_3.9.1_amd64.deb
        sudo apt-get install -f -y
        rm ipscan_3.9.1_amd64.deb
        echo "AngryIP installed successfully."
    fi
}

function install_essentials() {
    echo "Installing essential packages..."
    for package in "${ESSENTIAL_PACKAGES[@]}"; do
        sudo apt install -y "$package"
    done
    echo "Essential packages installed successfully."
}
function install_network_tools() {
    echo "Installing network tools..."
    for tool in "${NETWORK_TOOLS[@]}"; do
        sudo apt install -y "$tool"
    done
    echo "Network tools installed successfully."
}
function install_all() {
    install_essentials
    install_network_tools
    install_rust
    install_java
    install_angryoxide
    install_angryIPscanner
}
function install() {
    header
    echo "1. Install essential packages"
    echo "2. Install network tools"
    echo "3. Install Rust"
    echo "4. Install Java"
    echo "5. Install AngryOxide"
    echo "6. Install AngryIP"
    echo "7. Install all"
    echo "8. Exit"
    read -p "Select an option: " option

    case $option in
        1) install_essentials ;;
        2) install_network_tools ;;
        3) install_rust ;;
        4) install_java ;;
        5) install_angryoxide ;;
        6) install_angryIPscanner ;;
        7) install_all ;;
        8) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}

install