# Errores recurrentes: lib/platforms

| Fecha | Sitio | Error | Corrección |
|---|---|---|---|

Candidatos a vigilar mientras no haya historial propio:

- Comprobar el sistema operativo fuera de esta capa. Rompe la razón de ser del
  módulo y duplica la detección en sitios que después divergen.
- Suponer que un binario existe porque existe en macOS. Comprobar
  disponibilidad antes de invocar, no asumirla por nombre.
- Dar por equivalentes WSL2 y Git Bash. Comparten archivo pero no el mismo
  sistema de archivos ni las mismas rutas.
- Implementar solo tres de las cuatro funciones al añadir una plataforma.
