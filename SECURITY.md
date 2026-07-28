# Security Policy

## Supported Versions

Apple Security Lab is pre-1.0 and tracks a single moving target: the
`main` branch. Security fixes land there; there are no maintained
release branches yet.

## Reporting a Vulnerability

If you find a security issue in Apple Security Lab itself — not in a
target you're researching with it — please **do not open a public
GitHub issue**.

Instead, report it privately:

- Preferred: open a [GitHub Security Advisory](https://github.com/AlexGRDev/apple-seclab/security/advisories/new) for this repository.
- Alternative: contact the maintainer directly through GitHub (`AlexGRDev`).

Please include:

- A description of the issue and its impact.
- Steps to reproduce, or a minimal proof of concept.
- The affected command(s) or file(s), if known.

## What Counts

Apple Security Lab is a local CLI: install scripts, a package-manager
wrapper, and shell helpers for opening research sessions. Relevant
reports include (but aren't limited to):

- Command or argument injection in any `lib/commands/*.sh`,
  `lib/platforms/*.sh`, or `lib/profiles/*.sh` file.
- `seclab check`/`install` resolving to the wrong package, or running
  a privileged command it shouldn't.
- Anything that lets a malicious target directory or `.seclab-profile`
  file execute code outside the sandbox a user would reasonably expect.

## Response

This is an individually maintained project. There's no SLA, but
reports are read and acknowledged as soon as possible, and a fix or
mitigation is prioritized over new features.

## Scope Note

This project is intended for authorized security research only — see
[NOTICE](NOTICE). Vulnerabilities found in third-party tools that
Apple Security Lab installs or wraps (Frida, radare2, mitmproxy, and
so on) should be reported to those projects directly, not here.
