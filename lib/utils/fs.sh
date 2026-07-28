# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    fs.sh                                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:03:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 12:15:22 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

targets_dir() {
    echo "$SECLAB_TARGETS_DIR"
}

target_path() {
    local name="${1:?target name required}"
    echo "$(targets_dir)/$name"
}
