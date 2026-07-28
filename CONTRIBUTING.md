# Contributing to Apple Security Lab

First of all, thank you for considering contributing to **Apple Security Lab**.

This project aims to provide a reproducible framework for Apple security research across macOS, iOS and iPadOS. Contributions of any size are welcome, whether it's fixing a typo, improving documentation or implementing a new feature.

---

# Ways to Contribute

You can contribute by:

- Reporting bugs
- Improving documentation
- Fixing existing issues
- Adding new research profiles
- Improving platform compatibility
- Writing tests
- Refactoring existing code
- Proposing new features

If you're unsure whether something belongs in the project, feel free to open a discussion before investing time implementing it.

---

# Before You Start

Please:

- Search existing Issues and Pull Requests.
- Open an Issue before implementing large changes.
- Keep pull requests focused on a single feature or fix.
- Avoid unrelated formatting-only commits.

---

# Development Setup

Clone the repository:

```bash
git clone https://github.com/AlexGRDev/apple-seclab.git
cd apple-seclab
```

Verify your environment:

```bash
make check
```

Run ShellCheck:

```bash
make lint
```

Run formatting:

```bash
make fmt
```

Execute tests:

```bash
make test
```

---

# Project Structure

```
apple-seclab/

bin/
    seclab              CLI entrypoint, no logic of its own

lib/
    core/               bootstrap.sh, config.sh, environment.sh, dispatch.sh
    commands/           one <name>_cmd() per file, one file per command
    platforms/          host OS specific install/env helpers (macos, linux, windows)
    profiles/           research-target-type helpers (generic, ios, ...)
    utils/              shared, reusable code (colors, fs, helpers, packages, shell)

docs/           Documentation

examples/       Usage examples

tests/          Test suite

assets/         Images and branding
```

Please keep new files organized according to this structure.

---

# Coding Style

## Shell

- Bash is required (`#!/usr/bin/env bash`); this project relies on arrays,
  `[[ ]]`, `local`, and process substitution, none of which are portable
  to POSIX `sh`.
- Every file starts with the 42-style header block. Below it, only
  `# shellcheck ...` directives are allowed — no explanatory comments.
  Code should be readable from naming and structure alone.
- One command per file in `lib/commands/`, each exposing a single
  `<name>_cmd()` entry point. Commands must not source each other.
- Platform-specific behaviour (macOS/Linux/Windows) belongs only in
  `lib/platforms/`. Research-target-type behaviour (iOS, generic, ...)
  belongs only in `lib/profiles/`. Commands stay generic and delegate
  to both based on `$SECLAB_OS` / the target's `.seclab-profile`.
- Shared logic goes in `lib/utils/` — never duplicate the same check or
  helper across multiple files.
- Prefer readable code over clever one-liners; expand multi-statement
  functions across lines instead of `foo() { a; b; }`.
- Quote every variable unless the expansion is intentionally unquoted
  (word-splitting an optional flag) — add a
  `# shellcheck disable=SC2086` comment when that's the case.

Run ShellCheck before submitting a Pull Request.

---

# Commit Messages

Use `type(scope): description`, scoped to the file or directory the
commit actually touches. Keep each commit to one logical change.

Examples:

```
feat(profiles): add webkit research profile

fix(platforms): detect Homebrew on Apple Silicon

docs: improve installation guide

refactor(core): simplify platform detection
```

Common types: `feat`, `fix`, `refactor`, `build`, `docs`, `test`, `chore`, `del`.

---

# Pull Requests

A good Pull Request should:

- Have a clear title.
- Explain why the change is needed.
- Include documentation updates when applicable.
- Pass linting and tests.
- Avoid unrelated changes.

Small, focused pull requests are preferred over large ones.

---

# Security

If you discover a vulnerability in Apple Security Lab itself, **do not open a public issue**.

Please follow the responsible disclosure process described in:

```
SECURITY.md
```

---

# Code of Conduct

By participating in this project, you agree to be respectful, constructive and professional.

Harassment, personal attacks and disruptive behaviour will not be tolerated.

---

# License

By contributing to this repository, you agree that your contributions will be licensed under the **MIT License**.
