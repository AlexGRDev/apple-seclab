# apple-seclab

## Límite de scope

Este repositorio cubre investigación legítima sobre **artefactos propios de Apple**:
binarios del sistema, firmware e imágenes IPSW distribuidos por Apple, y código
propio compilado aquí. Mach-O, XNU, SEP, boot chain, Secure Boot, ARM64.

Queda **fuera de alcance**, y no se trabaja sobre ello en este repo:

- Binarios de terceros con la protección DRM retirada (FairPlay descifrado,
  `cryptid=0` en un ejecutable que se distribuye cifrado).
- Binarios de terceros re-firmados con un certificado personal para sideload.
- Parches, hooks o tweaks destinados a alterar el comportamiento de software
  comercial ajeno.

La frontera es la propiedad del artefacto y el estado de sus protecciones, no el
componente concreto que se esté analizando ni la intención declarada.

Investigación personal: Mach-O, firmware, IPSW, iOS, XNU, boot chain,
Secure Boot, SEP, ARM64. Herramientas: Ghidra, LLDB, Frida.
Aquí NO aplican las reglas anti-overengineering académicas — arquitectura
modular es bienvenida.
