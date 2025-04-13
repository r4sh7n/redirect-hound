#!/bin/bash

# ASCII Art Banner
banner() {
cat << "EOF"

   ____  _           _      _           _   _                 
  |  _ \| |         | |    (_)         | | (_)                
  | |_) | | ___  ___| |     _ _ __ ___ | |_ _  ___  _ __  ___ 
  |  _ <| |/ _ \/ __| |    | | '_ ` _ \| __| |/ _ \| '_ \/ __|
  | |_) | |  __/\__ \ |____| | | | | | | |_| | (_) | | | \__ \
  |____/|_|\___||___/______|_|_| |_| |_|\__|_|\___/|_| |_|___/

                     🕵️ Redirect Hound v1.0

EOF
}

# Self-installer
self_install() {
    echo "[*] Checking and installing required tools..."

    # Install Go (if not found)
    if ! command -v go &>/dev/null; then
        echo "[+] Installing Golang..."
        sudo apt update
        sudo apt install -y golang
    fi

    # Install gau (Go-based URL collector)
    if ! command -v gau &>/dev/null; then
        echo "[+] Installing gau..."
        go install github.com/lc/gau/v2/cmd/gau@latest
        export PATH=$PATH:$(go env GOPATH)/bin
        echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
    fi

    # Install other tools
    for tool in curl grep; do
        if ! command -v $tool &>/dev/null; then
            echo "[+] Installing $tool..."
            sudo apt install -y $tool
        fi
    done
}

# Open Redirect Scanner
run_detector() {
    green="\033[0;32m"
    red="\033[0;31m"
    blue="\033[0;34m"
    reset="\033[0m"

    echo -e "${blue}[+] Target:${reset} $domain"
    mkdir -p results/$domain
    echo -e "${blue}[*] Fetching JS-related URLs with redirect params...${reset}"
    ~/.local/bin/gau "$domain" 2>/dev/null | grep -Ei 'redirect=|url=|next=|return=' | sort -u > results/$domain/urls.txt

    echo -e "${blue}[*] Testing URLs for open redirects...${reset}"
    > results/$domain/vulnerable.txt

    while read -r url; do
        test_url="${url}evil.com"
        final=$(curl -s -L -o /dev/null -w "%{url_effective}" "$test_url")

        if [[ "$final" == *"evil.com"* ]]; then
            echo -e "${red}[!] Open Redirect Found:${reset} $test_url"
            echo "$test_url" >> results/$domain/vulnerable.txt
        fi
    done < results/$domain/urls.txt

    echo -e "${green}[✔] Scan complete. Results saved to:${reset} results/$domain/vulnerable.txt"
}

# Start
banner
self_install
read -p "Enter domain (example.com): " domain
run_detector
