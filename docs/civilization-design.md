# Diseño de Civilizaciones - Eastern European Expansion

## Criterios de Diseño

1. **Base histórica**: La civ base debe ser históricamente apropiada.
2. **Reutilización**: Todas las unidades reutilizan assets existentes.
3. **Diferenciación**: Cada civ tiene al menos 2-3 unidades únicas que la distinguen.
4. **Balance**: Las unidades son adaptaciones de unidades base con stats similares.

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
