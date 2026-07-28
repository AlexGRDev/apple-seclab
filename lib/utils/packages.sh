# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    packages.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 13:30:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 14:45:12 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

pkg_name_for() {
    local mgr="$1" default="$2"
    case "$default:$mgr" in
        python3:pacman|python3:scoop|python3:choco|python3:winget)
            echo "python"
            ;;
        ideviceinfo:apt|idevicesyslog:apt)
            echo "libimobiledevice-utils"
            ;;
        ideviceinfo:*|idevicesyslog:*)
            echo "libimobiledevice"
            ;;
        objdump:*|readelf:*)
            echo "binutils"
            ;;
        *)
            echo "$default"
            ;;
    esac
}

pkg_install() {
    local mgr="$1" pkg="$2"
    case "$mgr" in
        brew)   brew install "$pkg" ;;
        apt)    sudo apt-get install -y "$pkg" ;;
        dnf)    sudo dnf install -y "$pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pkg" ;;
        zypper) sudo zypper install -y "$pkg" ;;
        apk)    sudo apk add "$pkg" ;;
        winget) winget install -e --id "$pkg" --accept-source-agreements --accept-package-agreements ;;
        scoop)  scoop install "$pkg" ;;
        choco)  choco install -y "$pkg" ;;
        *)      return 1 ;;
    esac
}

pip_install() {
    local pkg="$1"
    python3 -m venv "$SECLAB_VENV" 2>/dev/null
    "$SECLAB_VENV/bin/pip" install --quiet --upgrade "$pkg"
}
