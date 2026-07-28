# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    shell.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 12:09:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:50:44 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

source "$SECLAB_ROOT/lib/utils/helpers.sh"

activate_venv
export PATH

alias t='cd "$SECLAB_TARGET_DIR"'
alias notes='${EDITOR:-vi} "$SECLAB_TARGET_DIR/README.md"'

capture() {
    local d="$SECLAB_TARGET_DIR/captures"
    mkdir -p "$d"
    cd "$d" || return 1
}

alias mitm='mitmproxy --listen-port 8888'
mitmdump-save() {
    local f
    f="$SECLAB_TARGET_DIR/captures/mitm-$(date +%Y%m%d-%H%M%S).flow"
    mkdir -p "$(dirname "$f")"
    mitmdump -w "$f" --listen-port 8888
}

alias r2='r2 -e bin.cache=true'
hex() {
    if have hexyl; then
        hexyl "$@"
    else
        xxd "$@"
    fi
}

echo "-----------------------------------------------"
echo "  seclab  ::  ${SECLAB_PROFILE:-generic}  ::  $SECLAB_TARGET_NAME"
echo "  host:    $SECLAB_OS ($SECLAB_DISTRO)"
echo "  cwd:     $SECLAB_TARGET_DIR"
[[ -n "${SECLAB_UDID:-}" ]] && echo "  device:  $SECLAB_UDID"
echo "-----------------------------------------------"
