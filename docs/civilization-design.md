# Diseño de Civilizaciones - Eastern European Expansion

> **Nota (2026-09-09)**: el contenido de las civs individuales más abajo en este archivo es
> el PLAN ORIGINAL (pre-implementación) y quedó desactualizado en varios puntos — nomenclatura
> `EEX*`, base real de Rumania (Otomanos en el plan, Rusia en la implementación real), unidades
> que nunca se construyeron tal cual (Knekt, Hakkapeliitta como unidad entrenable, etc.). El
> estado REAL de cada civ implementada está en **`docs/civs/`** (un `.md` por civ) — consultar
> ahí primero. Esta sección se conserva como referencia histórica del diseño original.

## Criterios de Diseño

1. **Base histórica**: La civ base debe ser históricamente apropiada.
2. **Reutilización**: Todas las unidades reutilizan assets existentes.
3. **Diferenciación**: Cada civ tiene al menos 2-3 unidades únicas que la distinguen.
4. **Balance**: Las unidades son adaptaciones de unidades base con stats similares.

## Reglas anti-bugs recurrentes (agregadas 2026-09-09 — aplican a TODA civ nueva o clonada)

Estas tres reglas nacen de bugs que se repitieron civ tras civ en este mod (ver
`docs/civs/*.md` y las memorias `aoe3-*-civ-clones-*` para los casos concretos). Revisarlas
SIEMPRE antes de dar por terminada una civ, no solo cuando el usuario las menciona.

1. **Toda reutilización de una civ real necesita que se llamen/registren los sonidos de
   edificios Y unidades — nunca asumir que "compartir el proto" alcanza.** El audio en AoE3
   DE se resuelve por nombre de proto (`Sound/<proto>_snds.xml`) y, para protos compartidos
   con `<civlogic>`, por nombre de CIV dentro de ese archivo. Una civ nueva que no aparece
   como `<choice>` en el civlogic de un proto compartido (Settler, Explorer, Grenadier,
   Dragoon, Hussar, CavalryArcher, Priest, Culverin, etc.) queda MUDA para ese proto aunque
   anime y funcione perfecto — el síntoma engañoso es que todo lo demás funciona. Checklist
   por cada civ nueva: por cada proto REAL compartido que la civ deja habilitado (tocado o
   heredado sin cambios), `grep -c "<civlogic>"` su `Sound/<proto>_snds.xml` de referencia; si
   da >0, hace falta una rama nueva. El fix confirmado en juego es SIEMPRE de dos pasos:
   registrar un soundset propio (`MM<Nombre>`) en `soundsetsde.mods.xml` Y copiar el/los
   `.wav` reales a `sound/mm/` — apuntar por nombre a un soundset vanilla sin copiar el
   archivo, o agregar civlogic a un archivo que nunca tuvo ninguno, NO funciona en juego
   (confirmado repetidas veces). Detalle completo: memoria `aoe3-unit-sounds-snds`.
2. **Toda unidad copiada/clonada (proto 100% nuevo) necesita su propio `sound/<proto>_snds.xml`
   desde el primer commit, no como paso posterior.** Un proto con nombre nuevo simplemente no
   tiene archivo de sonido — queda mudo aunque comparta animfile/tactics con la unidad real de
   la que se clonó. Al clonar una unidad, crear el `_snds.xml` en el MISMO cambio (copiar el de
   la unidad base y ajustar `<protounit name="...">`), reusando los soundsets reales que mejor
   encajen. Si el clon reemplaza/convive con un proto que YA tenía civlogic, el archivo nuevo
   debe ser PLANO (sin civlogic) — clonar por error la estructura con civlogic de un proto
   compartido para un proto ahora 100% propio también deja la unidad muda (esa civ nunca va a
   tener rama en un civlogic que ya no le corresponde).
3. **Al agregar el roster de una unidad nueva/copiada a un edificio, agregar SIEMPRE los
   botones de creación rápida (`<train>`) Y preguntar al usuario si la unidad necesita una
   línea de tecnologías de mejora por edad (Veterano/Guardia/Imperial o el patrón que
   corresponda) antes de darla por terminada.** No asumir en ningún sentido — ni que "no hace
   falta mejora porque el usuario no la pidió" ni que "hay que inventarle una mejora sin
   preguntar". Si la unidad reemplaza a un proto real que sí tenía su propia línea de mejoras,
   preguntar explícitamente si esa línea se mantiene (reusando las mejoras reales si el proto
   sigue siendo el mismo) o si hace falta clonarla (si el proto es compartido con otra civ del
   mod y no se puede tocar la mejora real sin filtrarle el cambio, ver
   `aoe3-shared-proto-per-player-extend`).

---

## HUNGRÍA (EEXHungary)

### Justificación Histórica de la Base
**Base elegida: Alemania (German)**

Justificación:
- Hungría fue parte del Imperio Habsburgo (Austro-Húngaro) durante la mayor parte del período AoE3 (1500-1850).
- La cultura militar húngara del siglo XVII-XIX está profundamente ligada al sistema imperial germano.
- El estilo de juego alemán (mercenarios, caballería pesada, población free) encaja con Hungría.
- La capital Budapest tiene arquitectura centroeuropea similar a Berlín o Viena.
- La Germany civ ya tiene una revolución húngara (`DERevolutionHungaryGerman`) que introduce unidades húngaras.

Alternativas descartadas:
- Polonia: Fue rival histórico de Hungría; diferentes unidades (lanzas vs. sables).
- Rusia: Demasiado oriental para Hungría del siglo XVII-XVIII.

### Identidad Visual
- Home City visual: Alemana (arquetipo centroeuropeo)
- Cultura: EasternEurope (igual que en la referencia de Polonia)
- Bandera: Placeholder con flag alemana (requeriría PNG personalizado para producción)

### Unidades Únicas (Barracas)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Hajduk** (EEXHajduk) | Musketeer | musketeer.xml | Infantería ligera de fuego |
| **Pandur** (EEXPandur) | Skirmisher | skirmisher.xml | Infantería ligera anti-cav |
| **Grenz Infantry** (EEXGrenz) | Halberdier | halberdier.xml | Infantería pesada |

### Unidades Únicas (Establos)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Magyar Hussar** (EEXMagyarHussar) | Hussar | hussar.xml | Caballería pesada de choque |
| **Hungarian Dragoon** (EEXHungarianDragoon) | Dragoon | dragoon.xml | Caballería de disparo |

### Bonificación de Civilización
- Los Hajduks cuestan -1 de población cuando se tienen más de 10 entrenados.
- Los Magyar Hussars pueden entrenarse desde Colonial (Age 1) en lugar de Fortress (Age 2).

### Políticos (Age-Up)
| Edad | Político | Efecto |
|---|---|---|
| Colonial (2) | Logistician | Envía carros militares + beneficios económicos |
| Fortress (3) | Marksman | Envía 6 Hajduks + mejora de disparo |
| Industrial (4) | Cavalier | Envía 4 Magyar Hussars + mejora de caballería |
| Imperial (5) | Royalist | Envía recursos + mejora general |

### Revolución
- DERevolutionHungaryGerman (ya existente en el juego) se reemplaza por:
- Una revolución otomana-húngara (Transylvania) como opción alternativa.

---

## RUMANIA (EEXRomania)

### Justificación Histórica de la Base
**Base elegida: Imperio Otomano (Ottomans)**

Justificación:
- Los principados de Valaquia y Moldavia fueron vasallos otomanos desde el siglo XV hasta el XIX.
- Las unidades militares rumanas del período (Dorobanți, Seimeni) son similares a las otomanas en equipamiento.
- El juego base incluye una revolución rumana (`DERevolutionRomania`) desde al menos los Otomanos/Rusos.
- Hay elementos de ambas influencias: Otomana (infantería y janícharos) y Eastern European (cosacos, caballería).
- El estilo Otomano (janissaries como élite, caballería variada) encaja con la historia rumana.

Alternativas descartadas:
- Rusia: Relación histórica post-1800; antes de eso Rumania estaba más bajo influencia otomana.
- Alemania: Poca conexión histórica directa en el período AoE3.

### Identidad Visual
- Home City visual: Rusa (arquetipo ortodoxo oriental europeo; la iglesia ortodoxa es central en Rumania)
  Alternativa: Otomana (si se prefiere resaltar la influencia otomana)
- Cultura: EasternEurope
- Bandera: Placeholder con flag rusa

### Unidades Únicas (Barracas)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Dorobant** (EEXDorobant) | Musketeer | musketeer.xml | Infantería de fuego pesada |
| **Seimeni** (EEXSeimeni) | Halberdier | halberdier.xml | Infantería de pica |
| **Pandur** (EEXRomanianPandur) | Skirmisher | skirmisher.xml | Tiradores ligeros |

### Unidades Únicas (Establos)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Curteni** (EEXCurteni) | Hussar | hussar.xml | Caballería noble |
| **Cossack** (reutilizar existente) | Cavalry/Dragoon | (ya en juego) | Caballería ligera |

### Bonificación de Civilización
- Los edificios de Rumania cuestan un 15% menos de madera (civilización forestal).
- Los Seimeni reciben un bonus de daño contra caballería pesada (+50%).

### Políticos (Age-Up)
| Edad | Político | Efecto |
|---|---|---|
| Colonial (2) | The Nobleman | Envía carros + bonificación económica de madera |
| Fortress (3) | The Voivode | Envía 6 Dorobanți + mejora |
| Industrial (4) | The Boyar | Envía 4 Curteni + mejora |
| Imperial (5) | The Prince | Envía recursos + gran mejora |

---

## FINLANDIA (EEXFinland)

### Justificación Histórica de la Base
**Base elegida: Suecia (Swedish)**

Justificación:
- Finlandia fue parte del Reino de Suecia desde 1249 hasta 1809 (más de 500 años).
- El período AoE3 (1492-1850) cae enteramente dentro del dominio sueco de Finlandia.
- Los soldados finlandeses (especialmente los Hakkapeliitat) formaban el núcleo del ejército sueco.
- La cultura militar finlandesa es indistinguible de la sueca en este período.
- Los Hakkapeliitat ya existen en el juego como mercenarios (`deMercHakkapeliitta`).
- El estilo sueco (caballería agresiva, carolinos como base de infantería) encaja perfectamente.

Alternativas descartadas:
- Rusia: Solo se convirtió en gobernante de Finlandia después de 1809 (final del período AoE3).
- Alemania: Sin conexión histórica directa con Finlandia.

### Identidad Visual
- Home City visual: Sueca (`swedish\swedish_homecity.xml`)
- Cultura: EasternEurope (o Northern Europe si existiera; usar EasternEurope como fallback)
- Bandera: Placeholder con flag sueca

### Unidades Únicas (Barracas)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Finnish Musketeer** (EEXFinnishMusketeer) | Musketeer | musketeer.xml | Infantería de fuego estándar |
| **Jaeger** (EEXJaeger) | Skirmisher | skirmisher.xml | Infantería ligera del bosque |
| **Knekt** (EEXKnekt) | Halberdier | halberdier.xml | Pikero pesado |

### Unidades Únicas (Establos)
| Unidad | Reemplaza | Asset Reutilizado | Rol Táctico |
|---|---|---|---|
| **Hakkapeliitta** (EEXHakkapeliitta) | Hussar | hussar.xml | Caballería de choque élite |
| **Finnish Dragoon** (EEXFinnishDragoon) | Dragoon | dragoon.xml | Caballería de disparo |

### Bonificación de Civilización
- Los Jaeger reciben +25% de velocidad en terreno forestal/agua.
- Los Hakkapeliitta cuestan menos madera y pueden entrenarse desde Colonial.
- Bonus al recolectar madera (+15%).

### Políticos (Age-Up)
| Edad | Político | Efecto |
|---|---|---|
| Colonial (2) | The Forest Guard | Envía Jaeger + mejora de madera |
| Fortress (3) | The Captain | Envía 6 Finnish Musketeers + mejora |
| Industrial (4) | The Commander | Envía 4 Hakkapeliitta + mejora |
| Imperial (5) | The Marshal | Envía recursos + gran mejora |

---

## Tabla Comparativa de Civilizaciones

| Aspecto | Hungría | Rumania | Finlandia |
|---|---|---|---|
| Base | Alemania | Otomanos | Suecia |
| Cultura | EasternEurope | EasternEurope | EasternEurope |
| Infantería principal | Hajduk (musket) | Dorobant (musket) | Finnish Musketeer |
| Infantería especial | Pandur (anti-cav) | Seimeni (anti-cav) | Jaeger (forest) |
| Caballería principal | Magyar Hussar | Curteni | Hakkapeliitta |
| Fortaleza | Caballería pesada | Infantería versátil | Bosque/velocidad |
| Debilidad | Sin artillería propia | Sin caballería élite | Sin infantería pesada |
| Visual HC | Alemán | Ruso | Sueco |
| Época histórica | 1600-1850 | 1500-1800 | 1500-1809 |

---

## Unidades del Juego Base Reutilizadas Directamente

Además de las unidades "wrapper" creadas, cada civ reutiliza:
- Settler (colono estándar)
- Falconet, Culverin, Mortar (artillería estándar europea)
- Caravel, Galleon, Frigate (barcos estándar)
- Outpost, Blockhouse (defensas estándar)
- Priest (curación)
- xpHorseArtillery (artillería a caballo si se habilita)
