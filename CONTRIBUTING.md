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

bin/            CLI entrypoint

lib/            Core implementation

docs/           Documentation

examples/       Usage examples

tests/          Test suite

assets/         Images and branding
```

Please keep new files organized according to this structure.

---

# Coding Style

## Shell

- Use POSIX-compatible shell whenever practical.
- Prefer readable code over clever one-liners.
- Quote variables unless expansion without quotes is intentional.
- Avoid unnecessary external commands.
- Write small reusable functions.

Run ShellCheck before submitting a Pull Request.

---

# Commit Messages

Use concise, descriptive commit messages.

Examples:

```
feat: add WebKit research profile

fix: detect Homebrew on Apple Silicon

docs: improve installation guide

refactor: simplify platform detection
```

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
