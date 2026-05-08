#!/usr/bin/env bash
# iOS / iPadOS helpers. Works from any host (macOS, Linux, WSL, Windows+WSL).
# Tools needed: libimobiledevice, pymobiledevice3.

devs() { idevice_id -l 2>/dev/null || pymobiledevice3 lockdown list-devices; }

devinfo() {
    if command -v ideviceinfo >/dev/null 2>&1; then
        ideviceinfo ${SECLAB_UDID:+-u "$SECLAB_UDID"}
    else
        pymobiledevice3 lockdown info ${SECLAB_UDID:+--udid "$SECLAB_UDID"}
    fi
}

syslog-capture() {
    local f
    f="$SECLAB_TARGET_DIR/captures/syslog-$(date +%Y%m%d-%H%M%S).log"
    mkdir -p "$(dirname "$f")"
    echo "Logging to $f (Ctrl-C to stop)"
    if command -v idevicesyslog >/dev/null 2>&1; then
        idevicesyslog ${SECLAB_UDID:+-u "$SECLAB_UDID"} | tee "$f"
    else
        pymobiledevice3 syslog live ${SECLAB_UDID:+--udid "$SECLAB_UDID"} | tee "$f"
    fi
}

screenshot-now() {
    local f
    f="$SECLAB_TARGET_DIR/captures/shot-$(date +%Y%m%d-%H%M%S).png"
    mkdir -p "$(dirname "$f")"
    pymobiledevice3 developer dvt screenshot "$f" ${SECLAB_UDID:+--udid "$SECLAB_UDID"}
    echo "Saved: $f"
}

ipsw-here() {
    local f="${1:?uso: ipsw-here <archivo.ipsw>}"
    f="$(realpath "$f")"
    cd "$SECLAB_TARGET_DIR" || return 1
    mkdir -p ipsw-work
    cd ipsw-work || return 1
    ipsw extract "$f" --kernel --dyld --files
}

ios-help() {
    cat <<'EOF'
iOS research checklist:
  1. Device USB-conectado, "Trust this computer" en el iPad/iPhone.
  2. devs                         -> lista de UDIDs
  3. devinfo                      -> info completa
  4. syslog-capture               -> logs a captures/
  5. screenshot-now               -> screenshot via developer mode
  6. ipsw-here <file.ipsw>        -> extrae kernel/dyld/files

Para MitM HTTPS desde el device:
  - mitm                          -> arranca mitmproxy en :8888
  - iPad: Wi-Fi -> Manual proxy -> <Mac-IP>:8888
  - iPad: visita http://mitm.it -> instala cert
  - Settings -> About -> Cert Trust -> habilitar
  - Apps con SSL pinning: añadir Frida + script de bypass.
EOF
}

echo "iOS env: devs, devinfo, syslog-capture, screenshot-now, ipsw-here, ios-help"
