# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    windows.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:15:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:38:19 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash
# shellcheck disable=SC2329

source "$SECLAB_ROOT/lib/utils/helpers.sh"

platform_check_title() {
    echo "Windows RE"
}

platform_check_list() {
    cat <<'EOF'
objdump (mingw)|objdump|manual
powershell.exe|powershell.exe|manual
EOF
}

platform_install_windows() {
    cat <<'EOF'
===============================================================
seclab :: install commands for Windows
===============================================================
seclab is a bash tool. On Windows you have two options.

## Option 1 (recommended) — WSL2 with Ubuntu

In an elevated PowerShell:
    wsl --install -d Ubuntu

After the reboot, inside WSL:
    git clone https://github.com/AlexGRDev/apple-seclab.git ~/apple-seclab
    cd ~/apple-seclab
    export PATH="$PWD/bin:$PATH"
    seclab install   # shows the apt/dnf/pacman commands for your distro

USB passthrough for iOS devices, via usbipd-win (elevated PowerShell,
Windows host, not WSL):
    winget install --interactive --exact dorssel.usbipd-win
    usbipd list
    usbipd bind    --busid <BUSID-of-your-device>
    usbipd attach  --wsl --busid <BUSID-of-your-device>

## Option 2 — Git Bash + Scoop (native, more limited)

No mature frida-tools/libimobiledevice on native Windows; fine for
static analysis and mitmproxy.

In PowerShell:
    iwr -useb get.scoop.sh | iex
    scoop install git python jq ripgrep fd bat hexyl
    scoop install radare2 ghidra
    scoop bucket add main
    scoop install mitmproxy
    pip install pymobiledevice3 frida-tools objection

Then, from Git Bash:
    git clone https://github.com/AlexGRDev/apple-seclab.git ~/apple-seclab
    echo 'export PATH="$HOME/apple-seclab/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    seclab check

Native Windows limits: no dtrace/strace, iOS dynamic analysis and SSL
pinning bypass via Frida are unreliable. For real RE work, use WSL2.
EOF
}

platform_env_windows() {
    have-pwsh() {
        have pwsh || have powershell.exe
    }

    pwsh-bin() {
        have pwsh && echo pwsh || echo powershell.exe
    }

    sig() {
        local f="${1:?usage: sig <file>}"
        if have-pwsh; then
            "$(pwsh-bin)" -NoProfile -Command "Get-AuthenticodeSignature '$f' | Format-List"
        else
            echo "sig: needs powershell.exe/pwsh on PATH (Git Bash or WSL interop)"
        fi
    }

    linked() {
        local f="${1:?usage: linked <file>}"
        if have objdump; then
            objdump -p "$f" | grep -i "DLL Name"
        else
            echo "linked: install mingw-w64 binutils for objdump, or inspect with Ghidra/pefile"
        fi
    }

    procs() {
        if have tasklist.exe; then
            tasklist.exe
        else
            ps -W 2>/dev/null || echo "procs: tasklist.exe not reachable from this shell"
        fi
    }

    trace-pid() {
        echo "trace-pid: no strace/dtrace on native Windows."
        echo "Use Sysinternals Procmon, or run seclab under WSL2 instead."
    }

    echo "Windows env: sig, linked, procs, trace-pid"
}
