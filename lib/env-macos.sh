#!/usr/bin/env bash
# macOS-specific helpers. Only loaded when host is macOS.

# Code signing / entitlements
csig()    { codesign -dvv --entitlements - "$1" 2>&1; }
entl()    { codesign -d --entitlements :- "$1" 2>/dev/null | plutil -p -; }
linked()  { otool -L "$1"; }
fwks()    { otool -L "$1" | grep -i framework; }

# Framework discovery
findfw() {
    local pat="$1"
    [[ -z "$pat" ]] && { echo "uso: findfw <pattern>"; return 1; }
    find /System/Library/{Frameworks,PrivateFrameworks} \
         /System/Library/CoreServices \
         -maxdepth 3 -iname "*${pat}*" 2>/dev/null
}

# dtrace helpers (need sudo)
trace-pid() {
    local pid="${1:?uso: trace-pid <pid>}"
    sudo dtrace -n "syscall:::entry / pid == $pid / { printf(\"%s\\n\", probefunc); }"
}

# IPSW (works on any OS but the macOS context often deals with kernel/system blobs)
alias ipsw-info='ipsw info'

echo "macOS env: csig, entl, linked, fwks, findfw, trace-pid, ipsw-info"
