# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    linux.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:12:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:36:02 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash
# shellcheck disable=SC2329

platform_check_title() {
    echo "Linux RE"
}

platform_check_list() {
    cat <<'EOF'
objdump|objdump|binutils
readelf|readelf|binutils
strace|strace|
EOF
}

platform_install_linux() {
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

# Frida + mitmproxy + iOS tooling via pip (newer than apt)
python3 -m venv "$SECLAB_ROOT/.venv"
source "$SECLAB_ROOT/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 mitmproxy \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

# Ghidra (not in apt) — manual download:
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

python3 -m venv "$SECLAB_ROOT/.venv"
source "$SECLAB_ROOT/.venv/bin/activate"
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

python -m venv "$SECLAB_ROOT/.venv"
source "$SECLAB_ROOT/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 mitmproxy \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

# Ghidra: yay -S ghidra
EOF
            ;;

        *)
            echo "Detected distro: $SECLAB_DISTRO (no preset)"
            echo "Use the equivalent packages in your package manager:"
            echo "  git python3 python3-venv jq ripgrep fd bat radare2 binutils binwalk"
            echo "  libimobiledevice usbmuxd libplist"
            echo "And via pip: frida-tools objection pymobiledevice3 mitmproxy pwntools"
            ;;
    esac

    cat <<'EOF'

Then:
    echo 'export PATH="$HOME/apple-seclab/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    seclab check
EOF
}

platform_env_linux() {
    linked() {
        ldd "$1" 2>/dev/null || objdump -p "$1" | grep NEEDED
    }

    syms() {
        nm -D "$1" 2>/dev/null | head -50
    }

    sect() {
        readelf -S "$1"
    }

    trace-cmd() {
        strace -f -e trace=all "$@"
    }

    trace-pid() {
        local pid="${1:?usage: trace-pid <pid>}"
        sudo strace -f -p "$pid"
    }

    psall() {
        ps -eo pid,user,comm,args --sort=pid
    }

    alias dexec='docker exec -it'

    echo "Linux env: linked, syms, sect, trace-cmd, trace-pid, psall"
}
