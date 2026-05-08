#!/usr/bin/env bash
# Print install commands for macOS. Does NOT execute anything itself —
# you copy/paste what you want.
cat <<'EOF'
===============================================================
seclab :: install commands for macOS
===============================================================
Prerequisites: Homebrew (https://brew.sh)

# --- Foundation ---
brew install git python3 jq ripgrep fd bat hexyl coreutils gnu-sed

# --- RE / dynamic analysis ---
brew install radare2 rizin
brew install --cask ghidra
brew install frida
brew install mitmproxy wireshark
brew install binwalk

# --- macOS specifics ---
brew install jtool2 p7zip xz

# --- IPSW analysis ---
brew tap blacktop/tap
brew install blacktop/tap/ipsw

# --- iOS device toolkit ---
brew install libimobiledevice ideviceinstaller usbmuxd libplist

# --- Python venv with frida-tools, pymobiledevice3, etc. ---
python3 -m venv "$HOME/Projects/seclab/.venv"
source "$HOME/Projects/seclab/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

Después: añade seclab al PATH:
    echo 'export PATH="$HOME/Projects/seclab/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    seclab check
EOF
