# Mach-O

Formato de ejecutable de Darwin. Un binario se divide en segmentos y secciones,
y la distinción importa antes de interpretar cualquier offset: `__text` y
`__stubs` contienen código, `__cstring` contiene literales de texto.

Regla de método que sale de ahí: antes de tratar un offset como puntero a
función, validar con `otool` en qué sección cae. Un offset dentro de `__cstring`
apunta a un literal, y saltar ahí provoca un crash propio.

Un binario puede ser fat (varias slices: `arm64`, `arm64e`, `x86_64`), y la
ausencia de la slice esperada es causa de fallo de carga.

Dónde se usa: [PITFALLS.md](../PITFALLS.md) recoge la regla de secciones y
el orden de diagnóstico; ~/Documents/Dev/crossover-steam/PITFALLS.md lo menciona al
comparar con los PE de Windows bajo Wine.

Relacionado: [arm64.md](arm64.md)
