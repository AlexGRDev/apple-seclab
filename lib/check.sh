#!/usr/bin/env bash
# Verify tools are present.
set -u
SECLAB_ROOT="${SECLAB_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
# shellcheck source=lib/platform.sh
source "$SECLAB_ROOT/lib/platform.sh"

ok=0; missing=0
check() {
    local name="$1" cmd="$2"
    if eval "$cmd" >/dev/null 2>&1; then
        printf "  \033[32m✓\033[0m  %-25s\n" "$name"
        ((ok++))
    else
        printf "  \033[31m✗\033[0m  %-25s  ← falta\n" "$name"
        ((missing++))
    fi
}

echo "Host: $SECLAB_OS ($SECLAB_DISTRO)"
echo
echo "Common:"
check "git"             "command -v git"
check "python3"         "command -v python3"
check "jq"              "command -v jq"
check "ripgrep (rg)"    "command -v rg"
check "radare2 (r2)"    "command -v r2"
check "frida"           "command -v frida"
check "mitmproxy"       "command -v mitmproxy"
check "ipsw"            "command -v ipsw"

if [[ "$SECLAB_OS" == "macos" ]]; then
    echo
    echo "macOS RE:"
    check "otool"        "command -v otool"
    check "codesign"     "command -v codesign"
    check "jtool2"       "command -v jtool2"
fi

if [[ "$SECLAB_OS" == "linux" || "$SECLAB_OS" == "wsl" ]]; then
    echo
    echo "Linux RE:"
    check "objdump"      "command -v objdump"
    check "readelf"      "command -v readelf"
    check "strace"       "command -v strace"
fi

echo
echo "iOS device toolkit (any host):"
check "ideviceinfo"     "command -v ideviceinfo"
check "idevicesyslog"   "command -v idevicesyslog"
check "pymobiledevice3" "command -v pymobiledevice3"
check "objection"       "command -v objection"

echo
echo "$ok ok, $missing missing"
[[ $missing -eq 0 ]] && echo "Todo presente." || echo "Falta algo. Corre: seclab install"
