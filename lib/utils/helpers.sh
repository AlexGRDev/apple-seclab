# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    helpers.sh                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 12:40:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 13:50:03 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

have() {
    command -v "$1" >/dev/null 2>&1
}

activate_venv() {
    [[ -d "$SECLAB_VENV" ]] && PATH="$SECLAB_VENV/bin:$PATH"
}
