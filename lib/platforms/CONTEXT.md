# lib/platforms

Capa de divergencia por sistema operativo. Un archivo por plataforma:
`macos.sh`, `linux.sh`, `windows.sh` (WSL2 o Git Bash).

## Contrato

Cada plataforma define las mismas cuatro funciones, con el sufijo de su nombre:

- `platform_install_<plat>()`
- `platform_env_<plat>()`
- `platform_check_title()`
- `platform_check_list()`

Las dos últimas se llaman igual en los tres archivos: solo se carga uno por
ejecución, así que no colisionan. Si alguna vez se cargasen dos, la última
ganaría en silencio.

## Regla de la capa

Aquí vive **todo** lo específico de sistema operativo: gestor de paquetes,
rutas, nombres de binarios, disponibilidad de herramientas. Ninguna otra capa
comprueba el sistema operativo por su cuenta.

Si un comando de `lib/commands/` necesita ramificar por plataforma, la
ramificación se añade aquí y el comando llama a la función común.

## Añadir una plataforma

Crear `<plat>.sh` con las cuatro funciones y cablear la detección en
`lib/core/environment.sh`. Implementarlas todas aunque alguna quede vacía: la
ausencia de una función se manifiesta como un fallo tardío y poco claro.
