# Apple Security Lab

[![shellcheck](https://github.com/AlexGRDev/seclab/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/AlexGRDev/seclab/actions/workflows/shellcheck.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Apple Security Lab** is an open-source framework for deploying reproducible security research environments across **macOS, iOS, iPadOS and Linux**.

Designed for reverse engineering, dynamic analysis, vulnerability research and Apple ecosystem security.

---

## Features

- 🍎 Apple-first workflow
- 🔬 Reproducible research environments
- ⚡ One-command workspace bootstrap
- 🧩 Modular architecture
- 📦 Cross-platform support
- 🛠 Built-in research helpers
- 📁 Structured research projects
- 📖 Writeups, captures and PoCs in one place

---

## Quick Start

```bash
seclab macos safari
```

```bash
seclab ios activation-lock
```

```bash
seclab linux kernel
```

```bash
seclab check
```

```bash
seclab install
```

---

## Why?

Security research should focus on understanding systems—not rebuilding your environment every morning.

Apple Security Lab automates the repetitive setup required for security research by preparing a consistent workspace with the right tooling, aliases and project structure.

Instead of spending time configuring shells, creating folders and remembering commands, you can immediately start reversing binaries, tracing processes or analysing devices.

---

## Research Workflows

Apple Security Lab supports workflows such as:

- Reverse Engineering
- Dynamic Instrumentation
- Binary Analysis
- Apple Platform Security
- Browser Security
- WebKit Research
- XNU Research
- Malware Analysis
- Device Forensics
- Vulnerability Research

---

## Supported Platforms

| Platform | Status |
|----------|--------|
| macOS (Apple Silicon) | ✅ Recommended |
| macOS (Intel) | ✅ Supported |
| Linux | ✅ Supported |
| WSL2 | ✅ Supported |
| Native Windows | ⚠ Experimental |

---

## Repository Structure

```
seclab/
├── bin/
├── lib/
├── modules/
├── profiles/
├── examples/
├── docs/
└── research/
```

Research projects are automatically organized as:

```
research/

project-name/

README.md

captures/

scripts/

binaries/

reports/

notes/
```

---

## Integrated Tooling

Apple Security Lab integrates naturally with tools commonly used by security researchers.

| Category | Examples |
|----------|----------|
| Reverse Engineering | Ghidra, Hopper, radare2 |
| Dynamic Analysis | Frida, LLDB |
| Binary Analysis | otool, nm, objdump |
| Apple Tooling | codesign, plutil, security |
| Device Research | libimobiledevice, idevice* |
| Network Analysis | mitmproxy, tcpdump |

---

## Roadmap

- [x] Workspace launcher
- [x] Cross-platform support
- [x] Research project scaffolding
- [ ] Modular profiles
- [ ] Frida integration
- [ ] LLDB helpers
- [ ] WebKit profile
- [ ] XNU profile
- [ ] Apple Silicon profile
- [ ] Automated research environments

---

## Philosophy

Apple Security Lab does **not** try to replace professional reverse engineering tools.

Instead, it provides a reproducible foundation that lets researchers spend less time configuring environments and more time understanding how Apple's software works.

---

## License

MIT

---

## Disclaimer

Apple Security Lab is intended exclusively for **authorized security research**.

Only use it against systems and devices that you own or have explicit permission to test.
