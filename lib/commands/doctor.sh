# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    doctor.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:33:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 14:50:41 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

doctor_cmd() {
    source "$SECLAB_ROOT/lib/utils/colors.sh"
    source "$SECLAB_ROOT/lib/utils/fs.sh"

    print_title "Host"
    print_ok "OS: $SECLAB_OS ($SECLAB_DISTRO)"

    echo
    print_title "Shell"
    if ((BASH_VERSINFO[0] >= 4)); then
        print_ok "bash $BASH_VERSION"
    else
        print_fail "bash $BASH_VERSION (need >= 4)"
    fi

    echo
    print_title "Filesystem"
    local dir
    dir="$(targets_dir)"
    if mkdir -p "$dir" 2>/dev/null && [[ -w "$dir" ]]; then
        print_ok "targets dir: $dir"
    else
        print_fail "targets dir not writable: $dir"
    fi

    echo
    print_title "Package manager"
    local mgr
    mgr="$(detect_pkg_manager)"
    if [[ -n "$mgr" ]]; then
        print_ok "$mgr"
    else
        print_fail "no supported package manager found"
    fi
}
