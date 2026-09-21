# lib/commands

Superficie de usuario del CLI. Un archivo por subcomando de `seclab`.

## Contrato

Cada comando cumple tres cosas, y `lib/core/dispatch.sh` depende de las tres:

1. El archivo se llama `<comando>.sh`.
2. Define una función `<comando>_cmd()`, sin sufijos ni variantes.
3. No se ejecuta nada al hacer `source`: solo define. `dispatch()` hace
   `source` y después invoca.

Comandos actuales: `help`, `version`, `doctor`, `check`, `install`, `env`,
`target`, `profile`.

## Añadir un comando

1. Crear `lib/commands/<nombre>.sh` con `<nombre>_cmd()`.
2. Añadir su rama al `case` de `lib/core/dispatch.sh`.
3. Registrarlo en la ayuda de `help.sh`.
4. Añadir su regla al `Makefile` si necesita instalación o comprobación propia.

Saltarse el paso 2 deja el comando invisible: no hay descubrimiento automático,
el `case` es la única fuente de verdad.

## Convenciones

Cabecera ASCII de 42 en cada archivo nuevo. Todo pasa shellcheck: es CI, no
opcional. Salida por las funciones de `lib/utils/colors.sh`, nunca `echo` con
códigos ANSI a pelo.
