# Example workflows

## iOS — investigate an Activation Lock bypass

```bash
seclab new al-bypass ios
seclab ios al-bypass --udid <YOUR-UDID>

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
seclab new sketchy-helper macos
seclab macos sketchy-helper

# inside:
cp /path/to/Sketchy.app/Contents/MacOS/Sketchy binaries/
csig binaries/Sketchy                   # signature + entitlements
linked binaries/Sketchy                 # linked frameworks
strings binaries/Sketchy | grep -iE 'http|key|token' | head
r2 -A binaries/Sketchy                  # interactive disasm
```

## Linux — container escape research

```bash
seclab new k8s-esc linux
seclab linux k8s-esc

# inside:
linked /usr/bin/runc
sect /usr/bin/runc
trace-cmd ls /                          # strace a command
```
