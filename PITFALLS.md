# PITFALLS: Custom IPSW iPhone4,1 / iOS 9.x

## P1: xpwntool no compila en macOS moderno

**Problema:** xpwntool usa OpenSSL 1.x API (`EVP_*` deprecada en OpenSSL 3.x) y
dependencias de libz con paths hardcodeados. Falla en macOS 12+ con clang moderno.

**Solucion:** Usar `img4tool` + `dmg` del proyecto `libdmg-hfsplus` como alternativa.
O aplicar el patch de OpenSSL 3 compatibility:
```
sed -i '' 's/EVP_CIPHER_CTX_init/EVP_CIPHER_CTX_reset/g' crypto.c
```
O compilar xpwntool con un SDK de macOS 10.x dentro de un entorno dockerizado
(Linux con openssl 1.1 funciona sin parches).

## P2: hdiutil attach falla en RootFS cifrado

**Problema:** El RootFS DMG de iOS esta cifrado (EncryptedDisk image). `hdiutil attach`
devuelve "no mountable file systems" sin la clave.

**Solucion:** Desencriptar primero con xpwntool o vfdecrypt usando los IV/Key de
The Apple Wiki antes de intentar montar. Verificar que el offset del encabezado
DMG coincide (iOS 9 usa formato UDZO con capa de cifrado AES-256-CBC).

## P3: Tamano del RootFS al reempaquetar

**Problema:** Al eliminar Setup.app (~10MB) y reempaquetar con hdiutil, el nuevo DMG
puede quedar con un tamano de particion distinto al esperado por `idevicerestore`,
que verifica el hash del RootFS DMG contra el BuildManifest.plist.

**Soluciones:**
- Usar `asr` para redimensionar antes de crear el DMG final.
- NO modificar `BuildManifest.plist` a mano para cuadrar el hash -- ese es el
  fichero que `idevicerestore` valida contra APTicket. En Pwned DFU (-P) esa
  validacion se bypasa, pero el tamano de particion debe ser >= al contenido.
- Reconstruir el DMG con el mismo tamano de particion que el original
  (no reducir, dejar espacio libre).

## P4: idevicerestore moderno y libimobiledevice version mismatch

**Problema:** `idevicerestore` compilado con libimobiledevice 2.x a veces falla en
el handshake TLS con dispositivos iOS 9 que solo soportan TLS 1.0.

**Solucion:** Compilar `idevicerestore` con `--with-openssl` explicitamente y
verificar que se enlaza contra OpenSSL 1.1.x o 3.x con SSLv3/TLS1.0 habilitado.
En macOS, usar `LDFLAGS="-L$(brew --prefix openssl@3)/lib"`.

## P5: Setup.app eliminado pero activacion requerida por SpringBoard

**Problema:** Eliminar solo el bundle `/Applications/Setup.app` no es suficiente.
En iOS 9, SpringBoard lee el flag `SBSetupDone` en
`/var/mobile/Library/Preferences/com.apple.springboard.plist`. Si el flag no
existe (primer boot), SpringBoard llama al daemon `mobileactivationd` que intenta
contactar con `albert.apple.com`. Puede resultar en pantalla negra o bucle de
activacion incluso sin Setup.app.

**Solucion:** Incluir en el ramdisk de restore (o en un script post-install) la
creacion del plist con `SBSetupDone = true` y el flag de activacion en
`/var/mobile/Library/Preferences/com.apple.purplebuddy.plist`:
```xml
<key>SetupState</key><string>OOBEFinished</string>
```
Tambien eliminar o parchear `mobileactivationd` si se requiere uso offline
permanente sin activacion de baseband.

## P6: ipwndfu y Python 3.x incompatibilidad

**Problema:** ipwndfu fue escrito para Python 2. Algunas versiones del fork 3.x
tienen bugs en el manejo de bytes/str en las llamadas USB que producen
`TypeError: a bytes-like object is required` en macOS con libusb >= 1.0.26.

**Solucion:** Usar el fork mantenido de axi0mX con soporte Python 3 o aplicar
el patch `bytes(payload, 'utf-8')` -> `payload` en `ipwndfu.py`. Verificar con
`python3 ipwndfu.py --demote` antes de intentar el exploit.

## P7: checkm8 en A5 requiere hardware USB especifico

**Problema:** El exploit checkm8 para A5 (S5L8940X) tiene requisitos de timing USB
muy estrictos. En algunos hubs USB 3.x el timing no es suficientemente preciso y
el exploit falla de forma no determinista.

**Solucion:** Usar un puerto USB-A nativo (no hub, no adaptador). En MacBook con
solo USB-C, usar un hub USB 2.0 (no 3.0) directamente en el adaptador. Intentar
varias veces (el exploit es de fuerza bruta de timing, 10-20 intentos normales).

## P10: vfdecrypt NO hay que compilarlo -- viene con dmg2img (Homebrew)

**Problema:** Se asume que vfdecrypt es parte de xpwn y requiere compilacion manual.

**Realidad:** `brew install dmg2img` instala `/opt/homebrew/bin/vfdecrypt` listo para usar.
La key de 72 hex chars de la wiki se pasa directamente con `-k`. No usar xpwntool.

## P9: img4lib no compila sin flags adicionales en macOS

**Problema:** `make` falla con `fatal error: 'openssl/aes.h' file not found` (default OpenSSL) o
`fatal error: 'lzfse.h' file not found` (submodulo lzfse vacio).

**Solucion:** Usar CommonCrypto + USE_LIBCOMPRESSION (no requieren dependencias externas):
```bash
make COMMONCRYPTO=1 \
  CFLAGS="-Wall -W -pedantic -Wno-variadic-macros -Wno-multichar -Wno-four-char-constants \
    -Wno-unused-parameter -O2 -I. -g -DiOS10 -DDER_MULTIBYTE_TAGS=1 -DDER_TAG_SIZE=8 \
    -D__unused='__attribute__((unused))' -DUSE_COMMONCRYPTO -DUSE_LIBCOMPRESSION" \
  LDLIBS="-lcompression -framework Security -framework CoreFoundation"
```

## P11: Hub USB bloquea restore mode en macOS 15 ARM64

**Problema:** Despues de que el restore OS (kernelcache) arranca en el iPhone 4s,
el dispositivo desaparece completamente del bus USB. No aparece en ioreg (IOUSBDevice)
ni en usbmuxd. idevicerestore espera el evento de usbmuxd que nunca llega y falla
con "Device failed to enter restore mode" tras 5 minutos.

**Causa:** Hub USB GenesysLogic entre el Mac ARM64 y el iPhone. El hub no re-enumera
el dispositivo correctamente cuando el restore OS reinicializa el controlador USB.
macOS 15 (Darwin 27.x) tiene incompatibilidades con la re-enumeracion de dispositivos
iOS 32-bit a traves de hubs USB.

**Sintoma concreto:** Logo de manzana estatico en pantalla (restore OS vivo), pero
`idevice_id -l` y `ioreg -c IOUSBDevice` devuelven 0 dispositivos durante toda la
espera.

**Soluciones:**
1. Conectar con adaptador USB-C -> USB-A simple (un solo conector, sin hub multi-puerto).
2. UTM + Ubuntu ARM64 + idevicerestore en Linux: Linux maneja hubs USB con dispositivos
   iOS 32-bit sin este problema. USB passthrough en UTM pasa el dispositivo directamente.
3. Mac con puerto USB-A nativo (Intel Mac o Mac antiguo).

**No funciona:** Reconectar el cable USB con el restore OS activo, aumentar el timeout
de idevicerestore, polling activo via idevice_get_device_list().

## P12: idevicerestore version y tamano de iBEC

**Problema:** La version reciente de idevicerestore (latest-26-gc52d923, libtatsu 1.0.5)
envia iBEC de 278924 bytes para el iPhone 4s y el dispositivo no responde (no pasa a
Recovery mode tras iBEC).

**Causa:** Diferencia en como se empaqueta el IMG3 con el ticket. La version antigua
(1.0.0-git-6cead6b, libtatsu 1.1.1) envia 281676 bytes y funciona.

**Solucion:** Usar ~/tools/idevicerestore/src/idevicerestore (version compilada
manualmente). NO usar el idevicerestore de Legacy-iOS-Kit ni ninguna version brew.

## P13: Empezar desde Recovery mode salta RestoreRamDisk

**Problema:** Si el dispositivo queda en Recovery mode de un intento anterior y se
lanza idevicerestore desde ese estado, puede saltar el envio del RestoreRamDisk.
Sin ramdisk, el restore OS no puede arrancar y el proceso falla.

**Solucion:** Siempre empezar desde DFU limpio. Apagar el dispositivo completamente
(hold Power + Home hasta apagarse) antes de lanzar idevicerestore.

## P8: baseband y iMessage/FaceTime post-flash

**Problema:** Si se elimina o parchea `mobileactivationd`, los servicios que
dependen de activacion de baseband (iMessage, FaceTime, llamadas) no funcionaran.

**Alcance:** Para un dispositivo de lab/investigacion sin SIM, aceptable. Para
uso con SIM, se necesita una activacion de baseband separada o mantener
`mobileactivationd` intacto y solo bypassear la UI de Setup.
