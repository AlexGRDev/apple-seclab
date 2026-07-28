# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:39:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 12:27:19 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

install_cmd() {
    case "$SECLAB_OS" in
        macos)
            source "$SECLAB_ROOT/lib/platforms/macos.sh"
            platform_install_macos
            ;;

        linux|wsl)
            source "$SECLAB_ROOT/lib/platforms/linux.sh"
            platform_install_linux
            ;;

        windows)
            source "$SECLAB_ROOT/lib/platforms/windows.sh"
            platform_install_windows
            ;;

        *)
            echo "Unsupported OS: $SECLAB_OS"
            return 1
            ;;
    esac
}
