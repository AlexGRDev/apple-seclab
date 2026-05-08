#!/usr/bin/env bash
# Common shell environment, sourced before the per-platform env.

export SECLAB_VENV="$SECLAB_ROOT/.venv"

# Activate Python venv if it exists.
if [[ -d "$SECLAB_VENV" ]]; then
    export PATH="$SECLAB_VENV/bin:$PATH"
fi

# Quick navigation
alias t='cd "$SECLAB_TARGET_DIR"'
alias notes='${EDITOR:-vi} "$SECLAB_TARGET_DIR/README.md"'
capture() {
    local d="$SECLAB_TARGET_DIR/captures"
    mkdir -p "$d"; cd "$d"
}

# Network helpers
alias mitm='mitmproxy --listen-port 8888'
mitmdump-save() {
    local f="$SECLAB_TARGET_DIR/captures/mitm-$(date +%Y%m%d-%H%M%S).flow"
    mkdir -p "$(dirname "$f")"
    mitmdump -w "$f" --listen-port 8888
}

# RE shortcuts (work on any OS where they're installed)
alias r2='r2 -e bin.cache=true'
alias hex='command -v hexyl >/dev/null && hexyl || xxd'

# Banner
echo "─────────────────────────────────────────────"
echo "  seclab  ::  $SECLAB_PLATFORM  ::  $SECLAB_TARGET_NAME"
echo "  host:    $SECLAB_OS ($SECLAB_DISTRO)"
echo "  cwd:     $SECLAB_TARGET_DIR"
[[ -n "${SECLAB_UDID:-}" ]] && echo "  device:  $SECLAB_UDID"
echo "─────────────────────────────────────────────"
