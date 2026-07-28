# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    environment.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 12:03:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 12:03:47 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

detect_os() {
    case "$(uname -s 2>/dev/null)" in
        Darwin)
            export SECLAB_OS="macos"
            export SECLAB_DISTRO="macos"
            ;;

        Linux)
            export SECLAB_OS="linux"
            if [[ -r /etc/os-release ]]; then
                # shellcheck disable=SC1091
                . /etc/os-release
                export SECLAB_DISTRO="${ID:-unknown}"
            else
                export SECLAB_DISTRO="unknown"
            fi
            if grep -qi microsoft /proc/version 2>/dev/null; then
                export SECLAB_OS="wsl"
            fi
            ;;

        MINGW*|MSYS*|CYGWIN*)
            export SECLAB_OS="windows"
            export SECLAB_DISTRO="git-bash"
            ;;

        *)
            export SECLAB_OS="unknown"
            export SECLAB_DISTRO="unknown"
            ;;
    esac
}

detect_pkg_manager() {
    local mgr

    case "$SECLAB_OS" in
        macos)
            command -v brew >/dev/null 2>&1 && echo "brew"
            ;;

        linux|wsl)
            for mgr in apt dnf pacman zypper apk; do
                if command -v "$mgr" >/dev/null 2>&1; then
                    echo "$mgr"
                    return 0
                fi
            done
            ;;

        windows)
            for mgr in winget scoop choco; do
                if command -v "$mgr" >/dev/null 2>&1; then
                    echo "$mgr"
                    return 0
                fi
            done
            ;;
    esac

    echo ""
}

detect_os
