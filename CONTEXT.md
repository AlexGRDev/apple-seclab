# CONTEXT: Custom IPSW iPhone4,1 (iOS 9.x)

## Target

| Campo | Valor |
|---|---|
| Modelo | iPhone 4s |
| Identifier | `iPhone4,1` |
| Chip | Apple A5 (S5L8940X) |
| BoardConfig | `n94ap` |
| DFU exploit | `limera1n` heap overflow via `ipwndfu` (bootrom S5L8940X, CPID 0x8940) |
| iOS objetivo | 9.3.5 (13G36) o 9.3.6 (13G37) -- ambas firmadas actualmente (nov 2026) |

## Estado de Blobs SHSH

**NO HAY blobs para iPhone4,1 / iOS 9.x en `Blobs/`.**

Blobs presentes en el repo (ninguno sirve para este target):

| Dispositivo | BoardConfig | iOS | ECID |
|---|---|---|---|
| iPhone5,2 | n42ap | 10.3.3, 10.3.4 | 980579319246 |
| iPhone9,3 | d101ap | 15.8.4 | 2614458668564538 |
| iPad11,2 | j211ap | 18.6, 26.x | 7991603255902254 |
| iPhone13,2 | d53gap | 18.6.2, 26.x, 27.x | 5635933575577630 |

**Consecuencia:** No se puede usar `futurerestore` con nonces fijados. El flujo
correcto es Pwned DFU + `idevicerestore -P` que bypasa verificacion APTicket
completamente (no requiere blobs).

## URLs IPSW iPhone4,1 (verificadas nov 2026)

- iOS 9.3.5 (13G36): `https://secure-appldnld.apple.com/iOS9.3.5/031-73068-20160825-6A2B99DE-6711-11E6-BB8F-133834D2D062/iPhone4,1_9.3.5_13G36_Restore.ipsw`
  - SHA1: `6f8e28e55662b35514a18fe010442464f3c596e6`
  - Estado firma Apple: **ACTIVA (nov 2026)**
  - Descargado en: `assets/ipsw/iPhone4,1_9.3.5_13G36_Restore.ipsw`
- iOS 9.3.6 (13G37): `https://updates.cdn-apple.com/2019/ios/041-80043-20190722-6C65AD27-69D8-499C-BC15-DE7AC74DE2BD/iPhone4,1_9.3.6_13G37_Restore.ipsw`
  - SHA1: `6ccddbfdf4a0d6747924252d379ad6d52f7d4ea8`
  - Estado firma Apple: **ACTIVA (nov 2026)**
- Referencia keys: https://theapplewiki.com/wiki/Firmware_Keys/9.x (seccion n94ap)

## Firmware Keys iOS 9.3.5 (13G36) n94ap

Fuente: https://theapplewiki.com/wiki/Keys:Genoa_13G36_(iPhone4,1)

Nota: RootFS DMG solo tiene Key (sin IV separado; AES-CBC con IV=0 o embebido en cabecera).

| Componente | Filename | IV | Key |
|---|---|---|---|
| RootFS DMG | 058-48374-036.dmg | (no separado) | `677d05afbb9a1eaa5f5e353829df15c4a5a6a2f7c2f354dadbff11e4aad7e97bf8f9275d` |
| Update Ramdisk | 058-49412-036.dmg | `f7c54e7bc52bd9001e576f7e7e19e423` | `9c2ede4bc5919de37d73d6eaeeb34d25bc01cd1012407c908862a538ea63a0cb` |
| Restore Ramdisk | 058-49032-036.dmg | `7842e2c239a2f8a5d8dac384cb308c94` | `3de170b9d5d0e4f22b6800f1ca9f82922b1e100c9f868cf32a957039fab21edb` |
| iBSS | iBSS.n94.RELEASE.dfu | `f0f347cec7eef72537b7056f72199cc3` | `3801b8387018fa15fa9d7aede1dd58e304401aaaeead4ae37100eb5b6e901ffc` |
| iBEC | iBEC.n94.RELEASE.dfu | `aaca923c569e477c0d6fb441a956722a` | `9da9c5a04bd3e41d3c5cfd41806905bf73b527b58aa4c9df82307ae6c570f5a8` |
| iBoot | iBoot.n94.RELEASE.img3 | `7543c02085f93d3f09445179b21a6c03` | `51d3590153a993d736d8054f1bffb7f4c540152f75b8f7d03867826114f083dd` |
| LLB | LLB.n94.RELEASE.img3 | `754c3721668fc7aee3012215a80c593f` | `df576bda22a146bf88c1d7d745ae51ff61e688c23f1e625da22f73600fe433ab` |
| Kernelcache | kernelcache.release.n94 | `ac20a4b047a64fe6b4a3a20a71ce784d` | `8971653fdb070f532d6e563e5e1cd589fca50d809c35689753556fbb5dd7f928` |
| DeviceTree | DeviceTree.n94ap.img3 | `21617cab22fd2738cad14f6f1604fae2` | `4800e1183963014bdd82a67df14271e5184c47e4b92f9f929e7f0363eeb4ccd2` |
| AppleLogo | applelogo@2x~iphone.s5l8940x.img3 | `c639ffd2a1ccc0ee5d85cbf89124150e` | `ecc1f57ccf4111b1db6f2fd4c9e9755db1c098908fd984194fe9d3cb1f3ae912` |
| RecoveryMode | recoverymode@2x~iphone-30pin.s5l8940x.img3 | `a5a0e378e2a3af395be60967439814df` | `87ef27a016fd8c0f61727b89d770d51387622e13a0ef9bfbcbcbfd92f4c09768` |
| GlyphPlugin | glyphplugin@2x~iphone-30pin.s5l8940x.img3 | `d2fee1254200ab0e89ba01d34ffeee7b` | `122426971dac07013226b215e0496e420713dd0a7b63101cadafa793531cd3a8` |
| BatteryCharging0 | batterycharging0@2x~iphone.s5l8940x.img3 | `4505554079ba368322dd6ba63beeb834` | `e43f4acbd30c448d31c5f12228611feb6ab6f86ccedb3fdc62c974c881a9ff6a` |
| BatteryCharging1 | batterycharging1@2x~iphone.s5l8940x.img3 | `2b8e09d0cc42d26de881170a6b582dd5` | `fb7630991c06138609a39177b5fbd5784bf9e8cd4dc8cff2b0dd091e559ee65c` |
| BatteryFull | batteryfull@2x~iphone.s5l8940x.img3 | `8fa19f132bb1e03f4b2ece4015a8e4eb` | `8ca7b13a69d788c6506190b7f7649c55ada8a7fc9efe7ea76f8a938dcd12c8a6` |
| BatteryLow0 | batterylow0@2x~iphone.s5l8940x.img3 | `a4b6044002a23a2a5b13da1c0de9c02b` | `fdd7cd5624dc3d14e8a38216e605dd58e42847e81329637561c080177cff4376` |
| BatteryLow1 | batterylow1@2x~iphone.s5l8940x.img3 | `34c896baeb65db42bfd1703943c0a6ea` | `8640ca7b2dadf6c78383fbfed75735ef85b8e837a12dd7cdeb0ca8077f919a0a` |

## Herramientas

### Instaladas

| Herramienta | Ruta | Notas |
|---|---|---|
| `hdiutil` | `/usr/bin/hdiutil` | Nativo macOS, montar/crear DMG |
| `asr` | `/usr/sbin/asr` | Apple Software Restore, nativo |
| `python3` | `/opt/homebrew/bin/python3` | 3.x Homebrew |
| `irecovery` | `/opt/homebrew/bin/irecovery` | Enviar comandos DFU/Recovery |
| `libimobiledevice` | Homebrew | Comunicacion con iOS |
| `libirecovery` | Homebrew | Backend de irecovery |
| `openssl@3/4` | Homebrew | Crypto |
| `xz` | Homebrew | Compresion LZMA/XZ |

### Faltantes criticas (instalar antes de Fase 2)

| Herramienta | Funcion | Fuente |
|---|---|---|
| `idevicerestore` | Restaurar IPSW en DFU/Pwned DFU | `brew install idevicerestore` |
| `ipwndfu` | Pwned DFU en A5 via checkm8 | https://github.com/axi0mX/ipwndfu |
| `img4tool` | Manipular IMG4/IM4P | `brew install img4lib` o build |
| `xpwntool` | Descifrar DMG EncryptedDisk | Build desde fuente (legacy) |
| `dmg` / `dmg2img` | Convertir Apple DMG | macOS: `brew install libdmg-hfsplus` |
| `pzb` | Partial Zip Browser (OTA) | Build desde fuente |
| `ldid` | Resign binarios sin codesign | `brew install ldid` |

## Formato de los ficheros extraidos del IPSW

| Fichero | Formato | Notas |
|---|---|---|
| `058-48374-036.dmg` | `encrcdsa` v2 (EncryptedDiskImage) | RootFS 1.47 GB cifrado AES; hdiutil/diskutil lo reconoce pero pide key |
| `058-49032-036.dmg` | IMAGE3 (`3gmI` = IM3G little-endian) | Restore Ramdisk 20 MB |
| `058-49412-036.dmg` | IMAGE3 | Update Ramdisk 21 MB |
| `kernelcache.release.n94` | IMAGE3 (`3gmI`) | Kernelcache 10 MB cifrado |

### Formato encrcdsa (RootFS)

Header de 16 bytes fijos:
- `0x00`: magic `encr` (4B)
- `0x04`: sig `cdsa` (4B)
- `0x08`: version = 2 (4B BE)
- `0x0c`: header_size = 0x10 = 16 (4B BE)

A continuacion descriptor variable:
- `0x10`: num_blocks = 5
- `0x14`: flags = 0x80000001
- `0x18`: key_bits = 0x80 = 128 (AES-128 CBC; confirmar con vfdecrypt)
- `0x1c`: 0x5b = 91 (IV size en bytes? inusual)
- `0x20`: 0xa0 = 160

La key de The Apple Wiki (72 hex chars = 36 bytes) NO esta embebida en el header.
Es el key blob externo que vfdecrypt usa directamente con `-k`.
**VERIFICADO:** descifrado exitoso -> UDZO valido (zlib, 2.15 GB, Apple Partition Scheme, CRC32 OK).
Herramienta: `vfdecrypt` (incluida en `dmg2img` via Homebrew, en `/opt/homebrew/bin/vfdecrypt`).

```bash
vfdecrypt -k 677d05afbb9a1eaa5f5e353829df15c4a5a6a2f7c2f354dadbff11e4aad7e97bf8f9275d \
  -i 058-48374-036.dmg -o rootfs_dec.dmg
```

### Formato IMAGE3 (ramdisks, kernelcache)

Magic `3gmI` = `IMG3` en little-endian. Formato IMAGE3 de Apple:
- Contiene tags: `KBAG` (key bag cifrada), `DATA` (payload), `CERT`, `SHSH`
- Para descifrar: `img4tool -d -k <IV><Key> -o out.dmg in.dmg` (o xpwntool)
- IV+Key concatenados del CONTEXT.md (tabla de firmware keys)

## Flujo de ataque resumido

```
1. Pwned DFU
   iPhone4,1 -> ipwndfu (limera1n) -> Pwned DFU

2. Descifrar RootFS
   vfdecrypt -i 058-48374-036.dmg \
     -k 677d05afbb9a1eaa5f5e353829df15c4a5a6a2f7c2f354dadbff11e4aad7e97bf8f9275d \
     -o rootfs_dec.dmg

3. Montar y modificar RootFS
   hdiutil attach rootfs_dec.dmg -mountpoint /tmp/rootfs
   rm -rf /tmp/rootfs/Applications/Setup.app
   # Crear plists de bypass activacion en ramdisk restore (ver P5)
   hdiutil detach /tmp/rootfs
   hdiutil convert rootfs_dec.dmg -format UDZO -o rootfs_mod.dmg

4. Reempaquetar Custom IPSW
   cp iPhone4,1_9.3.5_13G36_Restore.ipsw Custom_13G36.ipsw
   zip Custom_13G36.ipsw 058-48374-036.dmg  # reemplazar RootFS

5. Restaurar
   idevicerestore -P -e Custom_13G36.ipsw
```
