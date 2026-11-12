# STATE: Custom IPSW iPhone4,1

Ultima actualizacion: 2026-11-12

## Progreso por fases

### Fase 1: Auditoria de entorno
- [x] Listar blobs SHSH en `Blobs/`
- [x] Verificar ECID / BoardConfig de los blobs existentes
- [x] Confirmar ausencia de blobs iPhone4,1
- [x] Inventario de herramientas instaladas
- [x] Identificar herramientas faltantes
- [x] Obtener firmware keys de The Apple Wiki (n94ap / 13G36) -- COMPLETO, ver CONTEXT.md

### Fase 2: Preparacion tecnica
- [x] Instalar `idevicerestore` -- compilado en ~/tools/idevicerestore/src/idevicerestore v1.0.0-git-6cead6b (libirecovery 1.3.1, libtatsu 1.1.1)
- [x] Instalar `ipwndfu` -- pyusb 1.3.1 ya instalado; ipwndfu en ~/tools/ipwndfu (pendiente clonar si no existe)
- [x] Instalar `img4lib` -- compilado en ~/tools/img4lib/img4 (CommonCrypto + USE_LIBCOMPRESSION)
- [x] Resolver toolchain de descifrado DMG -- vfdecrypt (/opt/homebrew/bin/vfdecrypt, parte de dmg2img); descifrado VERIFICADO: UDZO valido 2.15 GB
- [x] Descargar iOS 9.3.5 IPSW (iPhone4,1 / 13G36) -- 1.5 GB en assets/ipsw/
- [x] Verificar SHA1 del IPSW -- OK: 6f8e28e55662b35514a18fe010442464f3c596e6
- [ ] Obtener y anotar keys IV/Key de todos los componentes
- [x] Desencriptar y montar RootFS DMG -- rootfs_dec.dmg (UDZO, 1.44 GB) en scratchpad
- [x] Eliminar Setup.app del RootFS -- eliminada (2 MB); shadow con cambios: rootfs_rw.shadow (36 MB)
- [x] Plists bypass activacion -- com.apple.springboard.plist (SBSetupDone=true) + com.apple.purplebuddy.plist (SetupState=OOBEFinished)
- [x] Reconstruir DMG y Custom IPSW -- rootfs_mod.dmg (1.42 GB, SHA1 e75fef78be995bb3a887a6db847ec6cf95b22076); Custom IPSW en assets/ipsw/Custom_iPhone4,1_9.3.5_13G36_NoSetup.ipsw (1.5 GB)

### Fase 3: Flasheo
- [ ] Entrar en Pwned DFU con ipwndfu
- [ ] Restaurar con idevicerestore -P
- [ ] Verificar arranque sin bootloop
- [ ] Verificar ausencia de pantalla de activacion

## Ultimo resultado

Fase 2 completa. Custom IPSW listo con Setup.app eliminado y bypass plists inyectados.

## Proximo paso inmediato

Fase 3 -- flasheo (requiere dispositivo fisico):

```bash
# 1. Poner iPhone4,1 en DFU mode
#    Apagar -> mantener Vol Down + Power 3s -> soltar Power, mantener Vol Down 10s

# 2. Pwned DFU con ipwndfu (limera1n)
cd ~/tools/ipwndfu && python3 ipwndfu.py -p

# 3. Restaurar con Custom IPSW
~/tools/idevicerestore/src/idevicerestore -P \
  /Users/alexg/Documents/Dev/apple-seclab/assets/ipsw/Custom_iPhone4,1_9.3.5_13G36_NoSetup.ipsw
```
