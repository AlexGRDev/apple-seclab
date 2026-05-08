# seclab :: instalación en Windows

`seclab` está escrito en bash. En Windows tienes dos opciones:

## Opción 1 (recomendada) — WSL2 con Ubuntu

```powershell
# En PowerShell como admin
wsl --install -d Ubuntu
```

Después de reiniciar:

```bash
# Dentro del WSL
git clone https://github.com/<your-user>/seclab ~/Projects/seclab
cd ~/Projects/seclab
seclab install   # te dará los comandos apt para Ubuntu
```

WSL2 tiene buen soporte de USB con `usbipd-win`:

```powershell
# En PowerShell admin (Windows host)
winget install --interactive --exact dorssel.usbipd-win
```

```powershell
usbipd list
usbipd bind --busid <BUSID-de-tu-iPad>
usbipd attach --wsl --busid <BUSID-de-tu-iPad>
```

Dentro del WSL, el iPad aparece como dispositivo USB normal y `libimobiledevice` lo ve.

## Opción 2 — Git Bash + Scoop (nativo)

Más limitada (no hay frida-tools maduro en Windows nativo, ni libimobiledevice
oficial). Sirve para análisis estático y mitmproxy.

```powershell
# Instala Scoop
iwr -useb get.scoop.sh | iex

# Tools
scoop install git python jq ripgrep fd bat hexyl
scoop install radare2 ghidra
scoop bucket add main
scoop install mitmproxy

# iOS: 3uTools / iTunes para drivers; pymobiledevice3 vía pip
pip install pymobiledevice3 frida-tools objection
```

Después abre **Git Bash** (no PowerShell) y:

```bash
git clone https://github.com/<your-user>/seclab ~/Projects/seclab
echo 'export PATH="$HOME/Projects/seclab/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
seclab check
```

Limitaciones de la opción 2: análisis dinámico iOS limitado, dtrace/strace no
existen, pinning bypass via Frida puede fallar. Si vas a hacer reverse
engineering serio en Windows, **usa WSL2**.
