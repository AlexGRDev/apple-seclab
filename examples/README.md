# Example workflows

## iOS — investigate an Activation Lock bypass

Works from any host (macOS, Linux, WSL, Windows via WSL).

```bash
seclab target new al-bypass ios
seclab env al-bypass

# inside the lab shell:
devs                                    # confirm device
devinfo > device-info.txt               # snapshot
syslog-capture &                        # capture in background
# ... reproduce the bypass on the device ...
fg                                      # back to foreground, Ctrl-C
screenshot-now                          # save proof
notes                                   # write up findings
```

## macOS — analyze a suspicious binary

```bash
seclab target new sketchy-helper generic
seclab env sketchy-helper

# inside:
cp /path/to/Sketchy.app/Contents/MacOS/Sketchy binaries/
csig binaries/Sketchy                   # signature + entitlements
linked binaries/Sketchy                 # linked frameworks
strings binaries/Sketchy | grep -iE 'http|key|token' | head
r2 -A binaries/Sketchy                  # interactive disasm
```

## Linux — container escape research

```bash
seclab target new k8s-esc generic
seclab env k8s-esc

# inside:
linked /usr/bin/runc
sect /usr/bin/runc
trace-cmd ls /                          # strace a command
```

## Windows — static analysis of a signed binary (Git Bash)

```bash
seclab target new pe-triage generic
seclab env pe-triage

# inside:
cp /c/path/to/sample.exe binaries/
sig binaries/sample.exe                 # Authenticode signature (via powershell.exe)
linked binaries/sample.exe              # imported DLLs (needs mingw-w64 binutils)
```

For dynamic analysis (Frida, dtrace/strace-equivalents), run seclab under
WSL2 instead — see `seclab install`.
