# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    check.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:36:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 14:47:33 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

install_missing_tools() {
    local mgr
    mgr="$(detect_pkg_manager)"

    echo
    print_title "Installing missing tools"

    local -a done_pkgs=()
    local entry binary pkg resolved

    for entry in "$@"; do
        binary="${entry%%|*}"
        pkg="${entry#*|}"

        if [[ "$pkg" == pip:* ]]; then
            echo "pip install ${pkg#pip:} (into $SECLAB_VENV)"
            pip_install "${pkg#pip:}"
            continue
        fi

        if [[ "$pkg" == "manual" || -z "$mgr" ]]; then
            echo "$binary: no automatic install available, run: seclab install"
            continue
        fi

        resolved="$(pkg_name_for "$mgr" "${pkg:-$binary}")"
        if [[ " ${done_pkgs[*]} " == *" $resolved "* ]]; then
            continue
        fi
        done_pkgs+=("$resolved")

        echo "$mgr install $resolved"
        pkg_install "$mgr" "$resolved"
    done

    echo
    echo "Re-run 'seclab check' to confirm."
}

check_cmd() {
    source "$SECLAB_ROOT/lib/utils/colors.sh"
    source "$SECLAB_ROOT/lib/utils/helpers.sh"
    source "$SECLAB_ROOT/lib/utils/packages.sh"
    activate_venv

    local ok=0 missing=0
    local -a missing_tools=()

    check_tool() {
        local label="$1" binary="$2" pkg="${3:-}"
        if have "$binary"; then
            print_ok "$label"
            ok=$((ok + 1))
        else
            print_fail "$label"
            missing=$((missing + 1))
            missing_tools+=("$binary|$pkg")
        fi
    }

    echo "Host: $SECLAB_OS ($SECLAB_DISTRO)"
    echo

    print_title "Common"
    check_tool "git"          "git"
    check_tool "python3"      "python3"
    check_tool "jq"           "jq"
    check_tool "ripgrep (rg)" "rg"        "ripgrep"
    check_tool "radare2 (r2)" "r2"        "radare2"
    check_tool "frida"        "frida"     "pip:frida-tools"
    check_tool "mitmproxy"    "mitmproxy" "pip:mitmproxy"
    check_tool "ipsw"         "ipsw"      "manual"

    case "$SECLAB_OS" in
        macos)     source "$SECLAB_ROOT/lib/platforms/macos.sh" ;;
        linux|wsl) source "$SECLAB_ROOT/lib/platforms/linux.sh" ;;
        windows)   source "$SECLAB_ROOT/lib/platforms/windows.sh" ;;
    esac

    if declare -f platform_check_list >/dev/null 2>&1; then
        echo
        print_title "$(platform_check_title)"
        while IFS='|' read -r label binary pkg; do
            check_tool "$label" "$binary" "$pkg"
        done < <(platform_check_list)
    fi

    echo
    print_title "iOS device toolkit (any host)"
    check_tool "ideviceinfo"     "ideviceinfo"     "libimobiledevice"
    check_tool "idevicesyslog"   "idevicesyslog"   "libimobiledevice"
    check_tool "pymobiledevice3" "pymobiledevice3" "pip:pymobiledevice3"
    check_tool "objection"       "objection"       "pip:objection"

    echo
    echo "$ok ok, $missing missing"

    if ((missing == 0)); then
        echo "Everything is present."
        return 0
    fi

    install_missing_tools "${missing_tools[@]}"
}
