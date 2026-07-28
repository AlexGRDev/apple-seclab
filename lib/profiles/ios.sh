# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ios.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:24:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:14:20 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash
# shellcheck disable=SC2329

source "$SECLAB_ROOT/lib/utils/helpers.sh"

profile_env_ios() {
    devs() {
        idevice_id -l 2>/dev/null || pymobiledevice3 lockdown list-devices
    }

    devinfo() {
        if have ideviceinfo; then
            # shellcheck disable=SC2086
            ideviceinfo ${SECLAB_UDID:+-u "$SECLAB_UDID"}
        else
            # shellcheck disable=SC2086
            pymobiledevice3 lockdown info ${SECLAB_UDID:+--udid "$SECLAB_UDID"}
        fi
    }

    syslog-capture() {
        local f
        f="$SECLAB_TARGET_DIR/captures/syslog-$(date +%Y%m%d-%H%M%S).log"
        mkdir -p "$(dirname "$f")"
        echo "Logging to $f (Ctrl-C to stop)"
        if have idevicesyslog; then
            # shellcheck disable=SC2086
            idevicesyslog ${SECLAB_UDID:+-u "$SECLAB_UDID"} | tee "$f"
        else
            # shellcheck disable=SC2086
            pymobiledevice3 syslog live ${SECLAB_UDID:+--udid "$SECLAB_UDID"} | tee "$f"
        fi
    }

    screenshot-now() {
        local f
        f="$SECLAB_TARGET_DIR/captures/shot-$(date +%Y%m%d-%H%M%S).png"
        mkdir -p "$(dirname "$f")"
        # shellcheck disable=SC2086
        pymobiledevice3 developer dvt screenshot "$f" ${SECLAB_UDID:+--udid "$SECLAB_UDID"}
        echo "Saved: $f"
    }

    ipsw-here() {
        local f="${1:?usage: ipsw-here <file.ipsw>}"
        f="$(realpath "$f")"
        cd "$SECLAB_TARGET_DIR" || return 1
        mkdir -p ipsw-work
        cd ipsw-work || return 1
        ipsw extract "$f" --kernel --dyld --files
    }

    ios-help() {
        cat <<'EOF'
iOS research checklist:
  1. Plug in the device, tap "Trust this computer".
  2. devs                         -> list connected UDIDs
  3. devinfo                      -> full device info
  4. syslog-capture               -> logs into captures/
  5. screenshot-now               -> screenshot via developer mode
  6. ipsw-here <file.ipsw>        -> extract kernel/dyld/files

HTTPS MitM from the device:
  - mitm                          -> start mitmproxy on :8888
  - device: Wi-Fi -> Manual proxy -> <host-IP>:8888
  - device: visit http://mitm.it -> install the cert
  - Settings -> About -> Cert Trust -> enable
  - Apps with SSL pinning: add a Frida bypass script.
EOF
    }

    echo "iOS profile: devs, devinfo, syslog-capture, screenshot-now, ipsw-here, ios-help"
}
