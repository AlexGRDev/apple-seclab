# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 12:00:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 12:00:47 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

SECLAB_VERSION="$(cat "$SECLAB_ROOT/VERSION" 2>/dev/null || echo "unknown")"
export SECLAB_VERSION
export SECLAB_TARGETS_DIR="${SECLAB_TARGETS_DIR:-$HOME/.seclab/targets}"
export SECLAB_VENV="$SECLAB_ROOT/.venv"
