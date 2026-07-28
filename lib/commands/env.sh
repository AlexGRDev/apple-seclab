# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    env.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:42:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 15:05:33 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

env_init_script() {
    cat <<'EOF'
source "$SECLAB_ROOT/lib/utils/shell.sh"

case "$SECLAB_OS" in
    macos)     source "$SECLAB_ROOT/lib/platforms/macos.sh";   platform_env_macos ;;
    linux|wsl) source "$SECLAB_ROOT/lib/platforms/linux.sh";   platform_env_linux ;;
    windows)   source "$SECLAB_ROOT/lib/platforms/windows.sh"; platform_env_windows ;;
esac

case "$SECLAB_PROFILE" in
    ios)     source "$SECLAB_ROOT/lib/profiles/ios.sh";     profile_env_ios ;;
    generic) source "$SECLAB_ROOT/lib/profiles/generic.sh"; profile_env_generic ;;
esac
EOF
}

launch_interactive_shell() {
    local init_script="$1"
    local shell_bin="${SHELL:-/bin/bash}"
    local shell_name
    shell_name="$(basename "$shell_bin")"

    case "$shell_name" in
        zsh)
            local rc_dir
            rc_dir="$(mktemp -d)"
            # shellcheck disable=SC2016
            echo '[ -r "$HOME/.zshenv" ] && source "$HOME/.zshenv"' > "$rc_dir/.zshenv"
            {
                echo 'unset ZDOTDIR'
                # shellcheck disable=SC2016
                echo '[ -r "$HOME/.zshrc" ] && source "$HOME/.zshrc"'
                echo "$init_script"
                echo "rm -rf '$rc_dir'"
            } > "$rc_dir/.zshrc"
            ZDOTDIR="$rc_dir" exec "$shell_bin" -i
            ;;

        bash)
            exec "$shell_bin" --rcfile <(echo "$init_script") -i
            ;;

        *)
            exec bash --rcfile <(echo "$init_script") -i
            ;;
    esac
}

env_cmd() {
    source "$SECLAB_ROOT/lib/utils/fs.sh"

    local target="${1:-scratch}"
    local target_dir
    target_dir="$(target_path "$target")"
    mkdir -p "$target_dir/captures"

    local profile="generic"
    [[ -r "$target_dir/.seclab-profile" ]] && profile="$(<"$target_dir/.seclab-profile")"

    export SECLAB_TARGET_NAME="$target"
    export SECLAB_TARGET_DIR="$target_dir"
    export SECLAB_PROFILE="$profile"

    cd "$target_dir" || return 1

    launch_interactive_shell "$(env_init_script)"
}
