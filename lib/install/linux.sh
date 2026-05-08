#!/usr/bin/env bash
# Print install commands for Linux. Detects distro and shows the right ones.
SECLAB_ROOT="${SECLAB_ROOT:-$(cd "$(dirname "$0")/../.." && pwd)}"
source "$SECLAB_ROOT/lib/platform.sh"

cat <<'EOF'
===============================================================
seclab :: install commands for Linux
===============================================================
EOF

case "$SECLAB_DISTRO" in
    ubuntu|debian|kali|pop|raspbian)
cat <<'EOF'
# Ubuntu / Debian / Kali

sudo apt update
sudo apt install -y git python3 python3-venv python3-pip \
    jq ripgrep fd-find bat hexyl \
    radare2 binutils binwalk wireshark-common tshark strace ltrace \
    libimobiledevice6 libimobiledevice-utils ideviceinstaller \
    usbmuxd libplist3 libusbmuxd-tools

# Frida + mitmproxy + tooling iOS via pip (más actualizados que apt)
python3 -m venv "$HOME/Projects/seclab/.venv"
source "$HOME/Projects/seclab/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 mitmproxy \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

# Ghidra (apt no la tiene) — descarga manual:
# https://github.com/NationalSecurityAgency/ghidra/releases

# ipsw (blacktop) — Linux release:
# https://github.com/blacktop/ipsw/releases
EOF
        ;;
    fedora|rhel|centos|rocky|almalinux)
cat <<'EOF'
# Fedora / RHEL family

sudo dnf install -y git python3 python3-virtualenv \
    jq ripgrep fd-find bat hexyl \
    radare2 binutils binwalk wireshark-cli strace ltrace \
    libimobiledevice libimobiledevice-utils \
    usbmuxd libplist

python3 -m venv "$HOME/Projects/seclab/.venv"
source "$HOME/Projects/seclab/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 mitmproxy \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate
EOF
        ;;
    arch|manjaro|endeavouros)
cat <<'EOF'
# Arch / Manjaro

sudo pacman -Syu --needed git python python-pip python-virtualenv \
    jq ripgrep fd bat hexyl \
    radare2 binutils binwalk wireshark-cli strace ltrace \
    libimobiledevice libplist usbmuxd

python -m venv "$HOME/Projects/seclab/.venv"
source "$HOME/Projects/seclab/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 mitmproxy \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

# Ghidra: yay -S ghidra
EOF
        ;;
    *)
        echo "Distro detectada: $SECLAB_DISTRO (no especificada)"
        echo "Usa el equivalente en tu gestor de paquetes:"
        echo "  git python3 python3-venv jq ripgrep fd bat radare2 binutils binwalk"
        echo "  libimobiledevice usbmuxd libplist"
        echo "Y por pip: frida-tools objection pymobiledevice3 mitmproxy pwntools"
        ;;
esac

cat <<'EOF'

Después:
    echo 'export PATH="$HOME/Projects/seclab/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    seclab check
EOF
