# Errores recurrentes: lib/commands

| Fecha | Sitio | Error | Corrección |
|---|---|---|---|

Candidatos a vigilar mientras no haya historial propio:

- Comando creado sin añadir su rama en `dispatch.sh`: queda inaccesible y no da
  error, simplemente cae en el caso por defecto.
- Código ejecutado a nivel de archivo en vez de dentro de `<comando>_cmd()`:
  se dispara en el `source`, antes de que `dispatch()` decida nada.
- Nombre de función que no coincide con el del archivo: `dispatch()` hace
  `source` correctamente y luego falla al invocar.
