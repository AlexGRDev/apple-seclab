# seclab

[![shellcheck](https://github.com/AlexGRDev/seclab/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/AlexGRDev/seclab/actions/workflows/shellcheck.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Cross-platform security research lab launcher. One command bootstraps a
shell environment configured for macOS, Linux or iOS/iPadOS device research.

```
seclab macos my-bug          # opens shell with macOS RE helpers
seclab linux container-esc   # opens shell with Linux RE helpers
seclab ios activation-lock   # opens shell with iOS device toolkit
seclab check                 # verify which tools are present
seclab install               # show install commands for your OS
seclab new <name> <type>     # scaffold a new research target dir
seclab list                  # list research targets
```

## Why

Every research session starts the same way: `cd` into the right folder,
remember the right aliases, hook up the device, set up the proxy, start
capturing logs. `seclab` collapses that ritual into a single command.

## Install

```bash
git clone https://github.com/AlexGRDev/seclab ~/Projects/seclab
echo 'export PATH="$HOME/Projects/seclab/bin:$PATH"' >> ~/.zshrc   # or ~/.bashrc
source ~/.zshrc
seclab install     # prints the install commands for your OS, you copy/paste
seclab check       # verify
```

| Host                | Status              |
|---------------------|---------------------|
| macOS (Apple Silicon / Intel) | First-class      |
| Linux (Debian / Ubuntu / Fedora / Arch) | First-class |
| Windows (WSL2 Ubuntu) | First-class      |
| Windows (native, Git Bash) | Limited      |

## Layout

```
seclab/
├── bin/seclab               # the launcher
├── lib/
│   ├── platform.sh          # OS detection
│   ├── env-common.sh        # shared aliases / banner
│   ├── env-macos.sh         # macOS RE helpers
│   ├── env-linux.sh         # Linux RE helpers
│   ├── env-ios.sh           # iOS device toolkit (any host)
│   ├── check.sh             # verify tools
│   └── install/             # per-OS install commands
└── examples/                # example research workflows
```

Research targets live in `~/.seclab/targets/<name>/` (override with
`SECLAB_TARGETS_DIR`). Each target has:

```
<target>/
├── README.md     # writeup as you go
├── captures/     # syslog, mitm flows, screenshots
├── binaries/     # samples under analysis
├── scripts/      # frida scripts, exploit prototypes
└── reports/      # finished writeups for bug bounty
```

## Helpers loaded per environment

### macOS env

| Helper        | What it does                              |
|---------------|-------------------------------------------|
| `csig <bin>`  | Code signature + entitlements             |
| `entl <bin>`  | Entitlements as readable plist            |
| `linked <bin>`| `otool -L` shorthand                      |
| `findfw foo`  | Search system frameworks                  |
| `trace-pid`   | dtrace syscalls for a PID                 |

### Linux env

| Helper        | What it does                              |
|---------------|-------------------------------------------|
| `linked <bin>`| `ldd` / `objdump -p` shorthand            |
| `syms <bin>`  | First 50 dynamic symbols                  |
| `sect <bin>`  | ELF section headers                       |
| `trace-cmd`   | strace for a command                      |
| `trace-pid`   | strace for a PID                          |

### iOS env (any host)

| Helper             | What it does                         |
|--------------------|--------------------------------------|
| `devs`             | List connected device UDIDs          |
| `devinfo`          | Full lockdown info                   |
| `syslog-capture`   | Stream + tee syslog to captures/     |
| `screenshot-now`   | Save dvt screenshot                  |
| `ipsw-here <file>` | Extract kernel/dyld/files from IPSW  |
| `ios-help`         | Cheat sheet                          |

## License

MIT — see [LICENSE](LICENSE).

## Disclaimer

This is tooling for *authorized* security research: your own devices,
your own systems, or systems where you have written permission. Do not
use it to attack services or devices you do not own or have explicit
authorization for.
