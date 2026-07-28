# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    profile.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:48:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 11:48:47 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

profile_cmd() {
    local sub="${1:-list}"

    case "$sub" in
        list) profile_list ;;
        *)    echo "Unknown profile subcommand: $sub"; return 1 ;;
    esac
}

profile_list() {
    cat <<'EOF'
Available profiles:
  generic   Bare workspace, no extra helpers (default)
  ios       iOS/iPadOS device research: devs, devinfo, syslog-capture,
            screenshot-now, ipsw-here, ios-help

Planned (see README roadmap): webkit, xnu, mach, tcc, sandbox
EOF
}
