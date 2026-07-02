# Changelog — Eastern European Expansion (EEX)

## [mod-minimal 1.1] — 2026-07-01 (Cambio 1 de gameplay: colonos → carretones)

Primer cambio de jugabilidad propia de Hungría, sin assets nuevos y sin afectar a
Alemania ni a otras civs. Detalle en `mod-minimal/README.md` (sección "Cambio 1").

### Agregado
- **`protomods.xml`** (nuevo): `HUNSettlerWagon`, copia civ-específica del proto
  base `SettlerWagon` (id/dbid 88881201) con `buildlimit=50`. Modificación del
  `TownCenter` (`mergeMode='modify'`) para agregar su botón de train.

### Cambiado
- Hungría entrena **carretones de colonos** (`HUNSettlerWagon`, 100 alimento + 100
  madera, máx. 50) en lugar de colonos: `Settler` deshabilitado y `HUNSettlerWagon`
  habilitado en el tech `HUNAge0` (civ-específico).
- **Barcos pesqueros** con límite propio de 50 (`FishingBoat BuildLimit=50` en
  `HUNAge0`), como cap independiente del de carretones.
- Unidades iniciales de `civmods.xml` (`townstartingunit` / `empirewarsstartingunit`)
  cambiadas de `SettlerWagon` a `HUNSettlerWagon`.
- `uitechtree/techtreedata_hunhungarians.xml`: la ficha de `Settler` del diagrama
  reemplazada por `HUNSettlerWagon`.

---

## [mod-minimal 1.0] — 2026-07-01 (✅ Civilización funcional confirmada en juego)

MRE (`mod-minimal`) — civilización **Hungría (`HUNHungarians`)** seleccionable y
jugable en Escaramuza. Clon completo de Germans con identidad propia. Documentación
completa en `mod-minimal/README.md`; historial de depuración en
`docs/mre-hungary-report.md`.

### Agregado
- **Metrópoli completa** (`homecityhungarymin.xml`): 211 cartas y 6 barajas
  (incluida la default), copiadas de Germans.
- **Árbol de tecnología** (`uitechtree/techtreedata_hunhungarians.xml`): layout UI
  copiado de Germans.
- **Techs de edad propios** (`techtreemods.xml`): 7 techs (`HUNAge0`…`HUNPostImperial`,
  dbids 88881101–88881107) que delegan por `TechStatus active` en los de Germans.
- **Strings en español** (`strings/spanish/stringmods.xml`): el juego solo carga el
  idioma del locale activo.

### Corregido (secuencia de bugs hasta la versión funcional)
1. `agetech` de Age1 apuntaba a `ColonizeGerman` (inexistente) → `ColonializeGerman`.
2. Faltaban los campos WPF de bandera/botón en `civmods.xml` (el selector WPF los
   requiere) → agregados, reutilizando assets de `DERevHungary` y Germans.
3. `civmods.xml` no tenía el bloque completo de una civ base → igualado 1:1 a Germans.
4. Faltaba `strings/spanish/` → creado (el juego corre en español).
5. La civ compartía literalmente los techs de Germans por nombre → techs propios.
6. **Causa final del bloqueo**: caché obsoleta en `Savegame\sp_HUNHungarians_homecity.xml`
   / `-v11.dat` de versiones rotas anteriores impedía que la civ se mostrara en las
   pantallas WPF pese a tener los datos correctos → borrada. Además, se desactivó el
   mod EEX (`localmod2`) para evitar colisión de nombre visible.

---

## [0.2.0] — 2026-06-27 (Bugfix crítico)

### Corregido
- **Mismatch de nombres de age techs** (bug crítico — civ no cargaba): civmods.xml usaba
  `EEXFortressizeHungary`/`EEXImperializeHungary` pero techtreemods.xml los definía como
  `EEXFortifyHungary`/`EEXEmpowerHungary`. Renombrados en techtreemods.xml para coincidir.
  Mismo arreglo para Romania (EEXFortressizeRomania, EEXImperializeRomania) y Finland.

- **Age0 techs incompletos** (bug crítico — no había edificios ni unidades): Los 3 techs
  Age0 (Hungary, Romania, Finland) ahora incluyen:
  - Todos los enables de edificios estándar europeos: TownCenter, HouseEast, Sheep, Capitol,
    ArtilleryDepot, Barracks, Stable, Plantation, TradingPost, Market, Arsenal, Outpost,
    Dock, CWallGate, WallStraight2/5/WallConnector, deTavern
  - Todas las unidades estándar: Settler, Priest, FieldHospital, Falconet, Culverin, Mortar,
    xpHorseArtillery, xpPetard, FishingBoat, Caravel, Galleon, Frigate, Monitor, xpSpy
  - Techs de sistema: XPTrickle, AAStandardStartingTechs, DEEuropeanStandardTechs, Levy
  - Techs imperiales/navales obtenibles: ImperialCannon, ImperialFieldGun, FieldGun, Bayonet,
    ImperialManOWar, ImperialMonitors, ImperialHorseArtillery, HeavyHorseArtillery
  - Techs de revolución obtenibles

- **Políticos no aparecían en TownCenter** (bug crítico): Todos los políticos de todas las
  edades (Colonial + Fortress + Industrial + Imperial) ahora son `obtainable` desde Age0.
  Antes estaban incorrectamente gateados por los shadow techs de cada edad.

- **Referencias a techs inexistentes** (crash al cargar): Eliminadas las referencias a
  `ColonizeShadow`, `FortifyShadow`, `IndustrializeShadow`, `EmpowerShadow` en los shadow
  techs de edad — esos nombres no existen en el juego base.

- **Nombre de edificio incorrecto**: `"Artillery Foundry"` → `ArtilleryDepot` (nombre interno correcto)

- **Nombres incorrectos en proto enables**: Eliminados `Church` y `Manor` de Age0 (nombres
  no verificados; `DEEuropeanStandardTechs` ya activa los edificios estándar)

- **Políticos no se eliminaban al subir de edad**: Agregadas entradas a `DERemoveAge3`,
  `DERemoveAge4`, `DERemoveAge5` con efectos `CommandRemove` (mergeMode="add") para las 3 civs.

- **Formato incorrecto en cartas de Home City**: El elemento `<name>` debe contener el nombre
  del tech directamente (ej: `<name>EEXHCShipHajduk3</name>`). No existe elemento `<tech>`
  separado. (Corregido en sesión anterior.)

### Documentación
- `docs/modding-reference.md`: Reescrito con el patrón correcto del Age0 tech, la lista
  completa de edificios a habilitar, el patrón de DERemoveAge, y la tabla de archivos
  additive de la documentación oficial de AoE3DE
- `TODO.md`: Actualizado para reflejar qué bugs fueron corregidos y qué queda por probar

---

## [0.1.0] — 2026-06-27 (Versión inicial)

### Agregado
- **Hungría (EEXHungary)**: Implementación completa
  - 5 unidades únicas: Hajduk, Pandur, Grenz Infantry, Magyar Hussar, Hungarian Dragoon
  - Árbol tecnológico Age0–Age4 (5 shadow techs de edad)
  - 12 techs de político (3 por nivel de edad)
  - 9 cartas de home city
  - Hungarian Explorer (animaciones alemanas)
  - Budapest home city (visuales alemanas)

- **Rumania (EEXRomania)**: Implementación completa
  - 5 unidades únicas: Dorobant, Romanian Pandur, Seimeni, Curteni, Romanian Explorer
  - Árbol tecnológico completo
  - 12 techs de político
  - 8 cartas de home city
  - Romanian Explorer (animaciones rusas)
  - Bucharest home city (visuales rusas)

- **Finlandia (EEXFinland)**: Implementación completa
  - 6 unidades únicas: Finnish Musketeer, Jaeger, Knekt, Hakkapeliitta, Finnish Dragoon, Finnish Explorer
  - Árbol tecnológico completo
  - 12 techs de político
  - 9 cartas de home city
  - Finnish Explorer (animaciones suecas)
  - Turku home city (visuales suecas)

- Upgrades Veteran/Guard/Imperial para todas las unidades
- Tabla de strings en inglés con nombres y descripciones completos
- Documentación: `docs/architecture.md`, `docs/civilization-design.md`, `docs/modding-reference.md`

### Técnico
- Todas las unidades reutilizan archivos de animación, iconos y tactics del juego base
- Rangos de IDs no colisionan con el mod de Polonia (77092xxx–77095xxx)
- Formato additive mod (mergeMode) para compatibilidad
