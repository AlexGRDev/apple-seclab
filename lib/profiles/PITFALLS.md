# Errores recurrentes: lib/profiles

| Fecha | Sitio | Error | Corrección |
|---|---|---|---|

Candidatos a vigilar mientras no haya historial propio:

- Asumir que hay un dispositivo conectado. Las funciones de listado devuelven
  vacío sin fallar: distinguir "sin dispositivos" de "herramienta ausente".
- Encadenar herramientas con fallback silencioso (`herramienta_a || herramienta_b`)
  sin decir cuál respondió. Enmascara que la primera no está instalada.
- Meter ramificación por sistema operativo aquí en vez de en `lib/platforms/`.
- Dar por instalada una dependencia del perfil sin declararla para `check`.
