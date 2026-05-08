#!/usr/bin/env bash
# Detect host OS and Linux distro. Exports SECLAB_OS and SECLAB_DISTRO.
# Sourced by every other script.

detect_platform() {
    case "$(uname -s)" in
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
            # Detect WSL specifically — useful for Windows users.
            if grep -qi microsoft /proc/version 2>/dev/null; then
                export SECLAB_OS="wsl"
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*)
            export SECLAB_OS="windows"
            export SECLAB_DISTRO="windows"
            ;;
        *)
            export SECLAB_OS="unknown"
            export SECLAB_DISTRO="unknown"
            ;;
    esac
}

# Pick the first available package manager for Linux.
detect_pkg_manager() {
    for mgr in apt dnf pacman zypper apk; do
        if command -v "$mgr" >/dev/null 2>&1; then
            echo "$mgr"
            return 0
        fi
    done
    echo ""
    return 1
}

detect_platform
