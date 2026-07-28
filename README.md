# Apple Security Lab

[![shellcheck](https://github.com/AlexGRDev/apple-seclab/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/AlexGRDev/apple-seclab/actions/workflows/shellcheck.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Apple Security Lab** is an open-source command-line framework for building reproducible security research environments across the Apple ecosystem.

It provides a modular CLI for setting up research workspaces, managing analysis profiles, validating development environments and organizing security research projects.

> Designed for macOS, iOS, iPadOS, Apple Silicon and cross-platform security research.

---

## Features

- 🍎 Apple-first security research workflow
- ⚡ Modular command-line interface
- 🔬 Reproducible research environments
- 📂 Structured research workspaces
- 🧩 Extensible command architecture
- 🛠 Built-in environment validation
- 📦 `check` auto-installs missing tooling via your package manager (or pip, into a repo-local venv)
- 🌍 Cross-platform (macOS, Linux, Windows via WSL2 or Git Bash)

---

# Installation

Clone the repository.

```bash
git clone https://github.com/AlexGRDev/apple-seclab.git
cd apple-seclab
```

Add the executable to your PATH.

```bash
export PATH="$PWD/bin:$PATH"
```

Verify the installation.

```bash
seclab version
```

---

# Quick Start

Display help.

```bash
seclab help
```

Verify your environment.

```bash
seclab doctor
```

Check installed tooling.

```bash
seclab check
```

Display installation instructions.

```bash
seclab install
```

Scaffold a research target and open its shell.

```bash
seclab target new my-target ios
seclab env my-target
```

---

# CLI

```
seclab <command> [arguments]

help                          Display help information

version                       Show current version

doctor                        Validate the host environment seclab itself needs

check                         Verify installed tools, auto-installing what's missing

install                       Display installation instructions for this OS

env [target]                  Open a research shell (default target: scratch)

target new <name> [profile]   Scaffold a new research target (default profile: generic)
target list                   List existing research targets

profile list                  List available research profiles
```

---

# Repository Structure

```
apple-seclab/

bin/
    seclab

lib/

    commands/

    core/

    platforms/

    profiles/

    utils/

docs/

examples/

tests/

assets/

.github/

LICENSE

NOTICE

README.md

SECURITY.md

Makefile
```

---

# Project Layout

```
bin/
```

CLI entry point.

```
lib/core/
```

Framework internals.

```
lib/commands/
```

User-facing CLI commands.

```
lib/platforms/
```

Platform-specific functionality.

```
lib/profiles/
```

Research profiles.

```
lib/utils/
```

Shared helper functions.

---

# Roadmap

## Core

- [x] Modular CLI architecture
- [x] Command dispatcher
- [x] Project documentation

## Environment

- [x] Platform detection (macOS, Linux, WSL, Windows)
- [x] Automatic dependency checks
- [x] Homebrew integration
- [x] Linux package manager support

## Research

- [x] Research targets
- [ ] Workspace templates
- [ ] Session management

## Apple

- [ ] WebKit profile
- [ ] XNU profile
- [ ] Mach profile
- [ ] TCC profile
- [ ] Sandbox profile
- [ ] Objective-C helpers
- [ ] Swift helpers
- [ ] Frida integration
- [ ] LLDB integration

---

# Philosophy

Apple Security Lab is designed to reduce the overhead of preparing research environments.

Rather than replacing existing reverse engineering tools, it provides a reproducible foundation that lets researchers focus on understanding systems instead of configuring them.

The project emphasizes:

- Simplicity
- Reproducibility
- Modularity
- Cross-platform compatibility
- Apple ecosystem research

---

# Contributing

Contributions are welcome.

Please read:

- CONTRIBUTING.md
- SECURITY.md
- NOTICE

before opening a Pull Request.

---

# License

Released under the MIT License.

See the [LICENSE](LICENSE) file for details.

---

# Disclaimer

Apple Security Lab is intended exclusively for authorized security research.

Only use this software on systems and devices that you own or are explicitly authorized to assess.
