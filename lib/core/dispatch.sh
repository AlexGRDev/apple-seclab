# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dispatch.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 10:46:39 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 10:47:06 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

dispatch() {

    local cmd="${1:-help}"
    shift || true

    case "$cmd" in

        help|-h|--help)
            source "$SECLAB_ROOT/lib/commands/help.sh"
            help_cmd "$@"
            ;;

        install)
            source "$SECLAB_ROOT/lib/commands/install.sh"
            install_cmd "$@"
            ;;

        check)
            source "$SECLAB_ROOT/lib/commands/check.sh"
            check_cmd "$@"
            ;;

        doctor)
            source "$SECLAB_ROOT/lib/commands/doctor.sh"
            doctor_cmd "$@"
            ;;

        env)
            source "$SECLAB_ROOT/lib/commands/env.sh"
            env_cmd "$@"
            ;;

        profile)
            source "$SECLAB_ROOT/lib/commands/profile.sh"
            profile_cmd "$@"
            ;;

        target)
            source "$SECLAB_ROOT/lib/commands/target.sh"
            target_cmd "$@"
            ;;

        version)
            source "$SECLAB_ROOT/lib/commands/version.sh"
            version_cmd
            ;;

        *)
            echo "Unknown command: $cmd"
            exit 1
            ;;

    esac
}
