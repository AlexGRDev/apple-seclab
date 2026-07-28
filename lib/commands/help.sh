# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    help.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:27:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 11:27:47 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

help_cmd() {
    cat <<'EOF'
seclab — cross-platform security research lab launcher

Usage:
  seclab <command> [arguments]

Commands:
  help                          Show this help
  version                       Show the current version
  doctor                        Validate the host environment
  check                         Verify installed research tooling
  install                       Show install commands for this OS
  env [target]                  Open a research shell (default target: scratch)
  target new <name> [profile]   Scaffold a new research target
  target list                   List existing research targets
  profile list                  List available research profiles

Project: https://github.com/AlexGRDev/apple-seclab
EOF
}
