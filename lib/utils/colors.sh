# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    colors.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:00:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 11:00:47 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

if [[ -t 1 ]] && [[ -z "${NO_COLOR:-}" ]]; then
    C_RED=$'\033[31m'
    C_GREEN=$'\033[32m'
    C_CYAN=$'\033[36m'
    C_BOLD=$'\033[1m'
    C_RESET=$'\033[0m'
else
    C_RED="" C_GREEN="" C_CYAN="" C_BOLD="" C_RESET=""
fi

print_ok() {
    printf "  %s%s%s  %-28s\n" "$C_GREEN" "✓" "$C_RESET" "$1"
}

print_fail() {
    printf "  %s%s%s  %-28s  <- missing\n" "$C_RED" "✗" "$C_RESET" "$1"
}

print_info() {
    printf "%s%s%s\n" "$C_CYAN" "$1" "$C_RESET"
}

print_title() {
    printf "%s%s%s\n" "$C_BOLD" "$1" "$C_RESET"
}
