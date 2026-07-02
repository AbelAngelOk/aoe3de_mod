# MRE Hungary — Informe de implementación

## Estado: ✅ FUNCIONANDO — confirmado en juego (2026-07-01)

La civilización **Hungría (`HUNHungarians`) aparece y es seleccionable** en
Escaramuza, con árbol de tecnología, cartas de metrópoli y barajas default
operativas. Documentación completa del mod en `mod-minimal/README.md`.

### Qué destrabó el problema final

Tras confirmar (vía editor de escenarios) que los datos del mod eran 100 %
correctos — la civ y sus 211 cartas / 6 barajas funcionaban perfectamente en el
editor, pero **no** en las pantallas WPF (Escaramuza, Ciudades Natales) — se
atacaron dos factores externos a los archivos del mod, y con eso empezó a
funcionar:

1. **Caché de Savegame obsoleta (causa principal)**: había
   `sp_HUNHungarians_homecity.xml` (creado **antes** de varios fixes de la sesión) y
   `sp_HUNHungarians_homecity-v11.dat` en la carpeta `Savegame` del perfil. Un hilo
   de HeavenGames sobre este mismo problema documenta que estos archivos de home
   city guardados quedan desincronizados de una civ recién corregida y **bloquean
   que se muestre** en las listas WPF. Se borraron ambos → el motor regeneró el
   estado desde cero con los datos ya correctos.

2. **Mod EEX (`localmod2`) habilitado a la vez**: define `EEXHungary` con un nombre
   visible similar ("Hungría"). Se desactivó dejando solo `minimal-hungary` activo,
   descartando cualquier colisión de nombre en las listas WPF.

### Lección clave

Cuando los datos del mod están confirmados correctos (verificado con
`DebugOutputGameData` y/o el editor de escenarios) pero la civ no aparece en las
pantallas WPF, el problema puede ser **estado cacheado fuera del mod**, no los
archivos del mod. Siempre limpiar `Savegame\sp_<Civ>_homecity*` tras corregir una
civ que se probó rota, y probar con un solo mod de civ nueva a la vez. Agregado a
la tabla de "Trampas Comunes" en `docs/modding-reference.md`.

---

## Historial — MRE completado antes de esta investigación (2026-06-30)

Tras el fix del tech-tree propio (Bug 5) el usuario seguía sin ver la civ en el
selector y volvió a la hipótesis original del proyecto (planteada desde el primer
mensaje): que faltan árbol de tecnología, cartas de metrópoli y barajas default, y
que eso podría estar dejando a la civ incompleta para el motor.

### Contenido agregado — home city completa y árbol de tecnología

Hasta ahora `homecityhungarymin.xml` tenía **1 sola carta y ningún `<decks>`**, y
no existía ningún archivo `uitechtree/techtreedata_hunhungarians.xml`. Se generaron
los tres, con el mismo enfoque de "copia exacta, solo cambiar el ID" que ya se usó
para `civmods.xml`:

- **`homecityhungarymin.xml`** regenerado como copia completa de
  `AoE3Reference/Data/homecitygerman.xml` (2889 líneas), cambiando solo `<civ>`
  (→ `HUNHungarians`), `<name>` y `<heroname>` (→ los strings propios de Hungría).
  Resultado: **211 cartas** y **6 barajas** (5 nombradas + `Beginner` marcada
  `<default>`), más los `<revoltdeck>` de Germans (inertes mientras Hungría no
  tenga civs de revolución propias, pero no deberían causar error). Todo el resto
  (visuales, `transportroundtriptime`, `ambientsounds`, `xsai`, `coffers`, etc. —
  campos que la versión mínima anterior tampoco tenía) queda igual que Germans.
- **`uitechtree/techtreedata_hunhungarians.xml`** (nuevo): copia exacta de
  `techtreedata_germans.xml` (408 líneas) — el layout del árbol de tecnología que
  se ve al abrir "Árbol de Tecnología" desde la Ciudad Natal. El nombre de archivo
  sigue el patrón `techtreedata_<nombre de civ en minúsculas>.xml`.

Ambos archivos y la carpeta `uitechtree/` sincronizados en la instalación
(`mods\local\minimal-hungary\data\`). **Pendiente confirmar en juego.**

Tras el fix de `strings/spanish` (Bug 4) el usuario probó de nuevo y reportó que
seguía sin funcionar (no se confirmó si retesteó específicamente ese fix o si
directamente pidió cambiar de estrategia). Se decidió cerrar la última diferencia
estructural real que quedaba contra los mods de referencia comprobados: tanto
`STARKPolish` como `MaoBavarians` (civs nuevas reales, no reskins) nunca apuntan
por nombre a los techs de una civ base — siempre definen sus propios techs de edad
con identidad e IDs propios.

### Bug 5 (hipótesis en curso) — HUNHungarians compartía literalmente los techs de Germans por nombre

`civmods.xml` apuntaba sus 5 `agetech` (+ post-industrial/imperial) directamente a
`Age0German`, `ColonializeGerman`, etc. — la civ nunca tuvo tech-tree propio, solo
referenciaba el de Germans por nombre. Se creó `mod-minimal/data/techtreemods.xml`
con 7 techs "envoltorio" propios (`HUNAge0`, `HUNColonialize`, `HUNFortressize`,
`HUNIndustrialize`, `HUNImperialize`, `HUNPostIndustrial`, `HUNPostImperial`, IDs
88881101–88881107) que simplemente activan (`TechStatus active`) el tech real de
Germans correspondiente — mismo patrón de delegación que ya usan los políticos del
mod completo EEX (ver `docs/modding-reference.md`). Así la civ tiene identidad de
tech-tree 100% propia sin transcribir miles de líneas de efectos (Industrialize/
ImperializeGerman miden más de 1000 líneas cada uno).

`civmods.xml` actualizado para apuntar a los nuevos techs propios en vez de a los
de Germans. Sincronizado en la carpeta instalada. **Pendiente confirmar en juego.**

Primera prueba en juego: la civ **no apareció correctamente** en el selector de Escaramuza.

### Bug 1 — `agetech` roto

En `civmods.xml`, el `agetech` de `Age1` referenciaba `ColonizeGerman`,
que no existe en el juego base. El nombre real (verificado contra
`AoE3Reference/Data/civs.xml` y `techtreey.xml`) es `ColonializeGerman` (con "iali").
Es la misma clase de bug ya documentada en `docs/modding-reference.md` ("Trampas
Comunes" → "Civ no aparece en el menú") y que ya había afectado al mod EEX completo
(ver `CHANGELOG.md` v0.2.0).

**Corrección**: `ColonizeGerman` → `ColonializeGerman` en `civmods.xml`.

### Bug 2 — faltaban los campos WPF de bandera/botón (la causa real de que siguiera sin funcionar tras el Bug 1)

`civmods.xml` solo incluía `homecityflagtexture` (la textura "clásica"), pero **el
selector de civilizaciones de Escaramuza en AoE3 DE está renderizado en WPF** y
lee campos aparte: `homecityflagiconwpf`, `homecitypreviewwpf`,
`homecityflagbuttonwpf`, `homecityflagbuttonset` (+ `large`), `postgameflagtexture`,
`postgameflagiconwpf`. **Todas** las civs reales revisadas en `AoE3Reference/Data/civs.xml`
(Spanish, Germans, etc.) y el mod de referencia funcional `STARKPolish`
(`example/109541_just poland - polish civilization/data/civmods.xml`) incluyen
estos campos sin excepción; el propio `docs/modding-reference.md` ya los documentaba
en su ejemplo de `civmods.xml`, pero **el MRE nunca los implementó**. Sin ellos, el
dato de la civ existe pero la UI en WPF no tiene con qué generar un elemento visual
para ella, así que queda ausente de la lista sin ningún error en los logs
(confirmado: `Age3Log.txt` no muestra errores en ninguna de las dos pruebas).
Confirmado también por reportes de la comunidad de modding de AoE3.

**Corrección**: agregados a `civmods.xml`, reutilizando assets 100% existentes:
- `homecityflagiconwpf`, `homecityflagbuttonwpf`, `postgameflagtexture`,
  `postgameflagiconwpf` → assets húngaros ya usados por `DERevHungary` en el juego base.
- `homecitypreviewwpf`, `homecityflagbuttonset`, `homecityflagbuttonsetlarge` →
  assets alemanes (`h_pc_germans.png`, `germanFlagBtn`/`germanFlagBtnLarge`), porque
  Hungary no tiene un botón propio en `buttonsets.xml` (no es additive-moddable) y
  el resto del mod ya reutiliza visuales alemanes.
- `matchmakingtextures` → copiado igual que Germans.

**Resultado**: tras esta corrección y reinicio completo del juego (confirmado por el
usuario, mod activo en Mods → Local Mods), Hungarians **seguía sin aparecer** en el
selector. Se verificó con `DebugOutputGameData` (ya estaba activo en
`Startup/user.cfg`) que el `civs.xml` fusionado en
`%TEMP%\Age of Empires 3 DE\Data\data\civs.xml` tenía la entrada de `HUNHungarians`
perfectamente resuelta — los 5 `agetech` correctos y todos los campos WPF del Bug 2
presentes tal cual. Es decir, la fusión de datos es correcta; el problema no está
en un XML mal formado o una referencia rota.

### Bug 3 (hipótesis en curso) — el MRE nunca tuvo el resto del bloque que usa cualquier civ real

Con los datos ya confirmados como sintácticamente correctos y aun así ausentes del
selector, se buscaron mods reales de civs completamente nuevas (no reskins de
revolución) como referencia adicional: `example/312759_abstract nations plus
(restore monarchy)/data/civmods.xml` agrega civs nuevas genuinas (`MaoBavarians`,
`MaoCanadian`, etc.) y — igual que `STARKPolish` — **copia el bloque `<civ>`
completo de una civ base** (`alliedid`/`alliedotherid`/`unalliedid`,
`postindustrialtech`/`postimperialtech`, `deathmatchtech`/`treatytech`/
`empirewarstech`, `buildingefficiency`/`freebuildingefficiency`, todos los
`empirewars*`, `randomstartingunits`, `unitregen`, `multipleblocktrain`) en vez de
un subconjunto mínimo. Ninguno de los dos mods reales usa una versión reducida.

**Corrección**: se igualó `civmods.xml` de `HUNHungarians` al bloque completo de
`Germans` (que es la civ que ya reutiliza en visuales/techs), cambiando solo los
campos identificadores propios de Hungría (nombre, statsid, portrait, strings,
homecityfilename, campos de bandera WPF ya corregidos en el Bug 2). Sincronizado en
la carpeta instalada.

**Resultado**: el usuario reinició el juego de nuevo y probó la pantalla de
**Ciudades Natales** (menú aparte del selector de Escaramuza) — Hungría **tampoco
aparece ahí**, ausente exactamente donde le tocaría alfabéticamente (entre
"Holandeses" e "Inca"). Mismo síntoma en dos pantallas distintas del juego.

### Bug 4 (causa raíz más probable) — falta `strings/spanish/stringmods.xml`

El juego corre en locale **Spanish** (confirmado en `Age3Log.txt`: `Game locale:
Spanish`, y en la propia UI del usuario: "ATRÁS", "NIVEL 51"). El mod **solo tenía**
`strings/english/stringmods.xml`. Se revisó el volcado de `DebugOutputGameData` de
la última prueba (`%TEMP%\Age of Empires 3 DE\Data\data\strings\`) y **solo existe
la carpeta `spanish/`** — el motor únicamente carga/fusiona el idioma que coincide
con el locale activo, nunca `english/` en una partida en español. El
`stringmods.xml` fusionado de `spanish/` no contiene ninguna cadena húngara (se
buscó `88881001`/`Hungarian`/`HUNHungarians` sin resultados).

Esto significa que `displaynameid` (88881001) y `rollovernameid` (88881002) de
`HUNHungarians` **nunca resuelven a ningún texto** en un juego en español. La
hipótesis es que el motor filtra/omite de las listas de civilizaciones (selector de
Escaramuza, Ciudades Natales) cualquier entrada cuyo nombre no resuelva a texto
válido — lo cual explica el mismo síntoma en ambas pantallas sin ningún error en
los logs, y por qué los Bugs 1–3 (todos correctos) no tuvieron ningún efecto
observable: ninguno tocaba el problema real.

Esto coincide con `docs/architecture.md`, que ya documentaba `strings/spanish/
stringmods.xml` como archivo necesario para el mod completo (EEX) — el MRE nunca
lo creó.

**Corrección**: creado `mod-minimal/data/strings/spanish/stringmods.xml` con los
mismos `_locid` (88881001–88881004) traducidos al español ("Húngaros", "Budapest",
"El Caudillo Magiar", etc.), siguiendo el mismo patrón que `strings/english/`.
Sincronizado en la carpeta instalada (incluyendo la subcarpeta `strings/spanish/`
que no existía ahí). **Pendiente confirmar en juego.**

Se descartaron como causa: el deck de 1 sola carta en `homecityhungarymin.xml`
(intencional en el MRE, no bloquea el selector) y la ausencia de archivos de IA
por civilización (`personalitiesmods.xml` es un sistema aditivo aparte que no
afecta la selección por un jugador humano).

Hipótesis implementada: **3 archivos** son suficientes para que una nueva civilización aparezca y sea jugable en Escaramuza.

---

## Archivos creados

| Archivo | Ruta en el proyecto | Descripción |
|---------|---------------------|-------------|
| `civmods.xml` | `mod-minimal/data/civmods.xml` | Registro de la civ HUNHungarians |
| `homecityhungarymin.xml` | `mod-minimal/data/homecityhungarymin.xml` | Home city mínima con visuales alemanes |
| `stringmods.xml` | `mod-minimal/data/strings/english/stringmods.xml` | Nombre "Hungarians" y tooltip |

**Carpeta de instalación:**
```
C:\Users\abela\Games\Age of Empires 3 DE\76561199061750162\mods\local\minimal-hungary\
```

---

## Registros necesarios identificados

### civmods.xml — campos mínimos confirmados

| Campo | Valor | Función |
|-------|-------|---------|
| `<name>` | `HUNHungarians` | Identificador interno único |
| `<main>1</main>` | `1` | **Controla si aparece en selector de Escaramuza** |
| `<statsid>` | `HM` | ID único de estadísticas (2-4 chars) |
| `<portrait>` | `objects\flags\hungarian` | Ícono en el selector (reutiliza DERevHungary) |
| `<culture>` | `EasternEurope` | Categoría cultural para el juego |
| `<settlerprotoname>` | `Settler` | Unidad que construye edificios |
| `<displaynameid>` | `88881001` | ID del string con el nombre visible |
| `<rollovernameid>` | `88881002` | ID del string con el tooltip |
| `<agetech>` × 5 | `Age0German`…`ImperializeGerman` | Techs de edad (reutiliza alemanes) |
| `<startingunit>` | `Explorer` | Unidad con la que comienza el jugador |
| `<townstartingunit>` × 4 | `Settler`, `CrateofFood`, etc. | Unidades/cajas iniciales en el TC |
| `<homecityfilename>` | `homecityhungarymin.xml` | Referencia al archivo de home city |
| `<homecityflagtexture>` | `objects\flags\hungarian` | Bandera en pantalla de home city |

### homecityhungarymin.xml — campos mínimos

| Campo | Valor | Función |
|-------|-------|---------|
| `<civ>` | `HUNHungarians` | Vincula este archivo con la civ |
| `<name>` | `$$88881003$$` | Nombre de la ciudad (Budapest) |
| `<visual>` | `german\german_homecity.xml` | Visual 3D de la ciudad |
| `<watervisual>` | `german\german_homecity_water.xml` | Visual del agua |
| `<backgroundvisual>` | `german\german_background.xml` | Fondo |
| `<camera>` | `german\german_homecity_camera.cam` | Cámara inicial |
| `<heroprotounits>` | `Explorer` | Héroe visible en home city |
| `<cards>` | 1 carta (HCShipSettlers1) | Deck mínimo con al menos 1 carta |

### stringmods.xml — strings necesarios

| ID | Valor | Función |
|----|-------|---------|
| `88881001` | `Hungarians` | Nombre en el selector de Escaramuza |
| `88881002` | Descripción | Tooltip en el selector |
| `88881003` | `Budapest` | Nombre de la ciudad en home city |
| `88881004` | `The Magyar Chieftain` | Nombre del héroe |

---

## Dependencias identificadas

```
civmods.xml
  ├── <agetech>Age0German</agetech>       → existe en juego base (techtreey.xml)
  ├── <agetech>ColonizeGerman</agetech>   → existe en juego base
  ├── <agetech>FortressizeGerman</agetech>→ existe en juego base
  ├── <agetech>IndustrializeGerman</agetech>→ existe en juego base
  ├── <agetech>ImperializeGerman</agetech>→ existe en juego base
  ├── <portrait>objects\flags\hungarian</portrait> → existe en juego base (DERevHungary)
  ├── <startingunit>Explorer</startingunit> → existe en juego base (protoy.xml)
  ├── <townstartingunit>Settler</townstartingunit> → existe en juego base
  ├── <displaynameid>88881001</displaynameid> → strings/english/stringmods.xml
  └── <homecityfilename>homecityhungarymin.xml</homecityfilename> → data/homecityhungarymin.xml

homecityhungarymin.xml
  ├── <visual>german\german_homecity.xml</visual> → existe en juego base
  ├── <heroprotounits><protounit>Explorer</protounit> → existe en juego base
  ├── <cards><name>HCShipSettlers1</name> → existe en juego base (techtreey.xml)
  └── <name>$$88881003$$</name> → strings/english/stringmods.xml
```

**Nada en este mod crea nuevos assets** — todo referencia archivos ya existentes en el juego.

---

## Validaciones realizadas

### Pre-instalación
- [x] Rutas de visuales alemanes verificadas en `AoE3Reference/Data/homecitygerman.xml`
- [x] Nombres exactos de age techs alemanes confirmados en `AoE3Reference/Data/civs.xml`
  — **corrección 2026-06-30**: esta verificación inicial no detectó que `Age1` usaba
  `ColonizeGerman` en vez de `ColonializeGerman`; ya corregido, ver nota de estado arriba.
- [x] Flag `objects\flags\hungarian` confirmada como existente (referenciada por DERevHungary)
- [x] Range de IDs 88881xxx confirmado como libre (EEX usa 77181xxx, Poland usa 77092xxx)
- [x] `DERevHungary` tiene `<main>0</main>` — sin conflicto con `HUNHungarians` (`<main>1</main>`)
- [x] Archivos instalados en `mods\local\minimal-hungary\data\`
- [x] Mod registrado en `age3-mod-status.json` con `Enabled: true`, priority 24

### Pendientes (requieren ejecutar el juego — re-probar tras el fix del 2026-06-30)
- [ ] Hungarians aparece en la lista de civilizaciones de Escaramuza
- [ ] Puede seleccionarse normalmente
- [ ] La partida inicia correctamente
- [ ] No hay errores en los logs relacionados con la civ

---

## Campos omitidos intencionalmente (a verificar si son requeridos)

Estos campos existen en la entrada de Germans pero fueron omitidos del MRE para descubrir si son obligatorios:

| Campo | Valor en Germans | ¿Requerido? |
|-------|-----------------|-------------|
| `<postindustrialtech>` | `PostIndustrialGerman` | Por determinar |
| `<postimperialtech>` | `PostImperialGerman` | Por determinar |
| `<deathmatchtech>` | `DEDeathMatch` | Probablemente no (solo para deathmatch) |
| `<treatytech>` | `DETreatyShadow` | Probablemente no (solo para treaty) |
| `<empirewarstech>` | `DEEmpireWars` | Probablemente no (solo para empire wars) |
| `<buildingefficiency>` | `0.3` | Por determinar |
| `<freebuildingefficiency>` | `1.0` | Por determinar |
| `<gameid>` | — | Usado por Poland mod, no por civs base |
| `<alliedid>` / `<unalliedid>` | `26446` / etc. | Strings diplomáticos, probablemente no |

Si el juego muestra errores en logs para alguno de estos campos, se agregan en la siguiente iteración.

---

## Próximos pasos para convertir el MRE en civ completa

Una vez validado que los 3 archivos funcionan, los componentes necesarios para una civ completa son:

### Componentes de funcionalidad básica
1. **`techtreemods.xml`** — Age0 shadow tech propio que habilite unidades específicas para Hungary (en lugar de reutilizar `Age0German`)
2. **`politicianmods.xml`** — Portraits para los políticos de edad (si se usan políticos propios)

### Componentes de contenido propio
3. **`protomods.xml`** — Añadir unidades húngaras a Barracks/Stable
4. **Unidades propias** en `protomods.xml` con stats y assets húngaros
5. **`unittypesmods.xml`** — Registrar categorías abstractas de las nuevas unidades
6. **`randomnamemods.xml`** — Nombres aleatorios para explorador, fuertes, naves

### Componentes opcionales/de pulido
7. **Localización adicional** — Más idiomas en `strings/[lang]/stringmods.xml`
8. **Flag propia** — En lugar de reutilizar `objects\flags\hungarian`
9. **Home city visual propia** — En lugar de visuales alemanes
10. **Home city completa** — Deck con cartas propias (15-25 cartas)
11. **IA** — Archivos en `game\ai\` para que la IA pueda jugar como Hungary
12. **Revoluciones** — Si se quiere implementar revoluciones propias

### Estimación de archivos totales para civ completa
- MRE (actual): 3 archivos
- Civ funcional con unidades propias: ~6-8 archivos
- Civ completa con IA y contenido: ~15-20 archivos
