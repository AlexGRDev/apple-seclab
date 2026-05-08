#!/usr/bin/env bash
# Linux-specific helpers. Loaded for Linux and WSL hosts.

# ELF helpers
linked() { ldd "$1" 2>/dev/null || objdump -p "$1" | grep NEEDED; }
syms()   { nm -D "$1" 2>/dev/null | head -50; }
sect()   { readelf -S "$1"; }

# Strace / ltrace shortcuts
trace-cmd() { strace -f -e trace=all "$@"; }
trace-pid() {
    local pid="${1:?uso: trace-pid <pid>}"
    sudo strace -f -p "$pid"
}

# Kernel module / process info
psall() { ps -eo pid,user,comm,args --sort=pid; }

# Container helpers (often needed in research)
alias dexec='docker exec -it'

echo "Linux env: linked, syms, sect, trace-cmd, trace-pid, psall"
