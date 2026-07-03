# Changelog — Eastern European Expansion (EEX)

## [mod-minimal 1.8] — 2026-07-02 (Ajustes de mejoras + retrato Honvéd)

### Cambiado
- **Retrato del Honvéd** (`honved.png`): ahora **64×64 llenando todo el marco** (sin
  margen transparente). Fuente: `honved.png` de la raíz (intacta).
- **Mejoras de cuartel** (Honvéd y Hajduk):
  - Velocidad por nivel **+0.15 → +0.10**.
  - Cada nivel ahora **renombra la unidad** (`SetName`) a su rango (Honvéd/Hajduk
    Veterano → de la Guardia → Imperial); ya no queda "Honvéd"/"Hajduk" a secas.
  - Strings de mejora en inglés a singular (sirven de nombre de unidad); rollovers
    actualizados a +0.10.
- Confirmado el gating "visible pero bloqueada": las 3 mejoras comparten slot; se ve
  solo la siguiente de la cadena, bloqueada por edad (Veterano→III, Guardia→IV,
  Imperial→V) hasta poder investigarla. (Ya estaba así desde 1.7; documentado.)

---

## [mod-minimal 1.7] — 2026-07-02 (Cambio 4: mejoras de cuartel propias)

### Quitado
- Las mejoras alemanas del cuartel (Veteran/Guard/Imperial de Crossbowman, Skirmisher,
  Pikeman, Dopplesoldner + Needle Gun) ya no aparecen para Hungría: se marcan
  `unobtainable` en `HUNAge0` (14 techs). Ya no correspondían a ninguna unidad del
  cuartel húngaro.

### Agregado
- **6 techs de mejora propias** (2 ramas × 3 niveles), `HUNVeteran/Guard/Imperial` +
  `Honved`/`Hajduk` (dbids 88881301–88881306):
  - Niveles 1 y 2: **+20%** vida y ataque, **+0.15** velocidad.
  - Nivel 3 (Imperial): **+50%** vida y ataque, **+0.15** velocidad.
  - Progresión acumulativa: Veterano (Fortaleza) → Guardia (Industrial, requiere
    Veterano) → Imperial (Imperial, requiere Guardia).
  - Nombres estilo estándar (Veterano/Guardia/Imperial), strings 88881020–88881025
    (+ rollovers 88881030–88881035) en inglés y español.
  - Botones agregados al `Barracks` (página 1) alineados bajo cada unidad; entradas
    en el diagrama del árbol de tecnología.

### Cambiado
- Orden del cuartel: **Honvéd primero, Hajduk segundo** (`train` col 0 y col 1).

---

## [mod-minimal 1.6] — 2026-07-02 (Hajduk: quitar UI de ascenso)

### Corregido
- El `HUNHajduk` seguía mostrando la UI de ascenso al abatir enemigos (acumulaba
  rangos sin beneficio). Causa: se había quitado el `<veterancybonus>` pero **no** el
  `<flag>ExperienceUnit</flag>`, que es el que hace acumular XP y ascender de rango.
  Eliminado ese flag → el Hajduk ya no asciende ni muestra la UI. (Validado: las 29
  unidades del juego base que ascienden tienen ambos; el Musketeer estándar no tiene
  ninguno.) Ambos —flag y veterancybonus— se re-agregarán a futuro con una carta.

---

## [mod-minimal 1.5] — 2026-07-02 (Honvéd: modelo camisa roja + icono con marco)

### Agregado
- `honved64.png` (64×64 con marco) como `<icon>` del Honvéd (botón del cuartel).

### Cambiado
- Modelo 3D del `HUNHonved`: de la casaca roja del consulado a la **"camisa roja"**
  (Redshirt/Garibaldini = `deColonialMilitia`, `units\infantry_ranged\colonial_militia\redshirt.xml`),
  la unidad que en el juego base solo aparece en el editor de escenarios.
- `<portraiticon>` del Honvéd sigue usando `honved.png` (retrato grande sin marco);
  `<icon>` ahora usa `honved64.png` (con marco).

---

## [mod-minimal 1.4] — 2026-07-02 (Honvéd: icono propio + modelo casaca roja)

### Agregado
- **Icono/retrato personalizado del Honvéd**: `honved.png` (retrato húngaro con chacó
  y dolmán) en `data\wpfg\resources\images\icons\hungary\honved.png`, referenciado en
  `<icon>`/`<portraiticon>` del proto `HUNHonved`. Primer asset propio del mod.
  (Convención de iconos de mod: `data\wpfg\resources\images\icons\…`.)

### Cambiado
- Modelo 3D del `HUNHonved`: de skirmisher del consulado a **casaca roja del consulado**
  (`units\asians\consulate\musketeer\musketeer.xml`) — animfile de mosquetero, acorde
  al rol melee+ranged del Honvéd, y con librea roja acorde al retrato.

---

## [mod-minimal 1.3] — 2026-07-01 (Cambio 3: Honvéd + Hajduk con stats de mercenario)

Reemplazo del mosquetero y del hajduk provisional por unidades con arte y stats
propios. Detalle en `mod-minimal/README.md` (sección "Cambio 3").

### Agregado
- **`HUNHonved`** (`protomods.xml`, id/dbid 88881203): el "mosquetero" de Hungría.
  Copia exacta del proto `Musketeer` base (todas sus stats) con el modelo/imagen del
  **fusilero de aguja prusiano** (`units\asians\consulate\skirmisher\skirmisher.xml` +
  iconos del skirmisher) y nombre **Honvéd**. Strings `88881013`–`88881015`.

### Cambiado
- **`HUNHajduk`** rehecho a partir del **Hajduk mercenario** del juego base
  (`deSaloonHajduk`): conserva modelo, iconos, 110 HP, carga cuerpo a cuerpo y todos
  los multiplicadores de daño. Excepciones pedidas: **no** es mercenario/outlaw
  (quitados los `unittype` de outlaw), cuesta **60 alimento + 60 oro** (antes 110 oro),
  **1 de población** (antes 3) y **sin veterancía/ascenso** (bloque `<veterancybonus>`
  eliminado; se recuperará a futuro con una carta).
- `HUNAge0` habilita `HUNHonved` + `HUNHajduk` (antes `Musketeer` base + Hajduk
  provisional). El cuartel de Hungría muestra solo esas dos unidades.
- `Barracks` (`protomods.xml`): botones de train de `HUNHonved` y `HUNHajduk`.
- `uitechtree`: grupo del cuartel actualizado a Honvéd + Hajduk.

---

## [mod-minimal 1.2] — 2026-07-01 (Cambio 2: roster de cuartel propio)

El cuartel de Hungría produce únicamente **mosqueteros y hajduks**. Detalle en
`mod-minimal/README.md` (sección "Cambio 2").

### Agregado
- **`HUNHajduk`** (`protomods.xml`, id/dbid 88881202): infantería propia de Hungría,
  mosquetero-reskin (90 HP, 60 alimento + 20 madera, `AbstractMusketeer`) que
  reutiliza animaciones/iconos del Musketeer base. Botón agregado al `Barracks`.
- Strings del Hajduk (`88881010`–`88881012`) en inglés y español.

### Cambiado
- `HUNAge0`: deshabilita la infantería de cuartel alemana (`Crossbowman`,
  `Skirmisher`, `Pikeman`, `Dopplesoldner`) y habilita `Musketeer` + `HUNHajduk`
  (civ-específico) → el cuartel muestra solo esas dos unidades.
- `uitechtree/techtreedata_hunhungarians.xml`: grupo del cuartel actualizado a
  Mosquetero + Hajduk.

---

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
