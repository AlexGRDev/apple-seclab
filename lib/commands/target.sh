# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    target.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: agarcia2 <agarcia2@student.42barcelona.co  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/07/28 11:45:00 by agarcia2          #+#    #+#              #
#    Updated: 2026/07/28 12:33:58 by agarcia2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
# shellcheck shell=bash

target_cmd() {
    source "$SECLAB_ROOT/lib/utils/fs.sh"

    local sub="${1:-list}"
    shift || true

    case "$sub" in
        new)  target_new "$@" ;;
        list) target_list ;;
        *)    echo "Unknown target subcommand: $sub"; return 1 ;;
    esac
}

target_new() {
    local name="${1:?target name required}"
    local profile="${2:-generic}"
    local dir
    dir="$(target_path "$name")"

    mkdir -p "$dir"/{captures,binaries,scripts,reports}
    echo "$profile" > "$dir/.seclab-profile"

    cat > "$dir/README.md" <<EOF
# $name ($profile)

Created: $(date -u +%Y-%m-%dT%H:%M:%SZ)
Host OS: $SECLAB_OS

## Hypothesis

## Surface

## Findings
EOF

    echo "Target created: $dir"
}

target_list() {
    local dir
    dir="$(targets_dir)"
    echo "Targets in $dir:"

    local d found=0
    for d in "$dir"/*/; do
        [[ -d "$d" ]] || continue
        printf "  %s\n" "$(basename "$d")"
        found=1
    done

    [[ "$found" -eq 1 ]] || echo "  (none)"
}
