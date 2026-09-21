# lib/profiles

Perfiles de investigación. Un perfil define qué herramientas y qué entorno se
montan para un tipo concreto de trabajo.

Perfiles actuales: `generic`, `ios`.

## Contrato

Cada perfil define `profile_env_<nombre>()`, que prepara el entorno y expone las
funciones de conveniencia propias del perfil.

`lib/commands/profile.sh` es quien los selecciona; los perfiles no se cargan
solos.

## Dónde encaja

Esta es la capa con conocimiento de dominio: `platforms/` sabe de sistemas
operativos, `profiles/` sabe de investigación. El tooling de dispositivo
(`idevice_id`, `pymobiledevice3` y similares) vive aquí, no en `platforms/`.

## Límite de scope

Aplica el límite del `CLAUDE.md` del repo: artefactos propios de Apple. Un
perfil no es un lugar para meter tooling orientado a binarios de terceros con
DRM retirado o re-firmados. Si un perfil nuevo necesita algo así, el perfil no
va aquí.

## Añadir un perfil

Crear `<nombre>.sh` con `profile_env_<nombre>()` y registrarlo en
`lib/commands/profile.sh`. Declarar sus dependencias para que `check` pueda
instalarlas.
