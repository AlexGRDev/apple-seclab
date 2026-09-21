# ARM64

Arquitectura de 64 bits de ARM (AArch64), la de todo el silicio Apple moderno.
Base de trabajo del proyecto: los binarios que se analizan son ARM64, y las
variantes con autenticación de punteros (`arm64e`, PAC) cambian el análisis
respecto a `arm64` puro.

Consecuencia práctica que ya ha aparecido: un loader o tweak sin slice `arm64e`
falla en su propia inicialización y tumba el proceso antes de que se ejecute
nada propio, lo que se confunde con un bug del código bajo análisis.

Dónde se usa: [CONTEXT.md](../CONTEXT.md) lo declara como uno de los ejes
de investigación; ~/Documents/Dev/crossover-steam/PITFALLS.md lo toca desde el otro
lado, traducción x86 a ARM64 bajo Wine y Rosetta.

Relacionado: [mach-o.md](mach-o.md)
