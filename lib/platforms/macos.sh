# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    macos.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:09:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:33:40 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash
# shellcheck disable=SC2329

platform_check_title() {
    echo "macOS RE"
}

platform_check_list() {
    cat <<'EOF'
otool|otool|manual
codesign|codesign|manual
jtool2|jtool2|manual
EOF
}

platform_install_macos() {
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
python3 -m venv "$SECLAB_ROOT/.venv"
source "$SECLAB_ROOT/.venv/bin/activate"
pip install --upgrade pip
pip install frida-tools objection pymobiledevice3 \
            pwntools capstone keystone-engine unicorn \
            requests rich beautifulsoup4
deactivate

Then add seclab to your PATH:
    echo 'export PATH="'"$SECLAB_ROOT"'/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    seclab check
EOF
}

platform_env_macos() {
    csig() {
        codesign -dvv --entitlements - "$1" 2>&1
    }

    entl() {
        codesign -d --entitlements :- "$1" 2>/dev/null | plutil -p -
    }

    linked() {
        otool -L "$1"
    }

    fwks() {
        otool -L "$1" | grep -i framework
    }

    findfw() {
        local pat="${1:?usage: findfw <pattern>}"
        find /System/Library/{Frameworks,PrivateFrameworks} \
             /System/Library/CoreServices \
             -maxdepth 3 -iname "*${pat}*" 2>/dev/null
    }

    trace-pid() {
        local pid="${1:?usage: trace-pid <pid>}"
        sudo dtrace -n "syscall:::entry / pid == $pid / { printf(\"%s\\n\", probefunc); }"
    }

    alias ipsw-info='ipsw info'

    echo "macOS env: csig, entl, linked, fwks, findfw, trace-pid, ipsw-info"
}
