# Caballeros Hospitalarios (`HOSHospitalarios`)

**Clon de**: Malta (`DEMaltese` — civ real COMPLETA del juego base, no una revolución). **IDs**:
88889xxx. **Agregada**: v10.0. Techs `HOS*` delegan en las reales de Malta
(`DEAge0Maltese`...`DEPostImperialMaltese`). Reusa la bandera/buttonset REALES de Malta
(`objects\flags\malta`, `maltaFlagBtn`) — esta civ ES la identidad histórica real de los
Caballeros de Malta/Hospitalarios, sin necesidad de asset nuevo. Home city
(`homecityhosmin.xml`) copia literal de `homecitymaltese.xml`.

## Identidad
Al activar `DEAge0Maltese` se heredan automáticamente TODOS los assets reales de Malta: el
Hospitaller (`deHospitaller`, con su línea de mejoras `DEVeteranHospitallers`/
`DEGuardHospitallers`/`DEImperialHospitallers`), Mosquetero maltés propio
(`deMalteseMusketeer`), Piquero (`Pikeman`), Ballestero (`Crossbowman` — ya cubre el pedido
"Ballesteros" sin trabajo extra), Lanzador de Fuego (`deHoopThrower`, ver Fundición abajo),
toda la economía/edificios/políticos reales, y el bono de curación de unidades específicas al
estar idle (`LogicalTypeMalteseCivBonusHealsWhenIdle`).

## Inicio
Sin Explorador estándar: Malta real ya usa su propio héroe-explorador (`deGrandMaster`, no un
`Explorer` normal). Se creó **`HOSMorganBlack`** — clon completo de `deGrandMaster` (mismas
stats/tactics/comandos de construcción: TownCenter/TradingPost/Outpost/deDepot/deMalteseGun/
FortFrontier + habilidades de bandera inspiradora/carga de carabina/golpe pesado) con el
modelo/ícono REALES del héroe de campaña Morgan Black (`SPCMorgan`,
`units\spc\morgan_black\spc_morgan_black.xml`) y sus strings reales reutilizadas
(`displaynameid`/`rollovertextid` = locids reales 25278/32463, "Líder de los Caballeros de
San Juan de Malta"). Sonido: `hosmorganblack_snds.xml` plano, reusa los soundsets reales
`MorganBlackSelect/Grunt/Death/Acknowledge/Attack/Revive` — el `deGrandMaster` real YA tiene
un `skinlogic` con Morgan Black como variante "0", así que estos soundsets ya existen en el
juego base.

## Cuartel
- **Ballesteros** = `Crossbowman` real, heredado automático (sin trabajo extra).
- **Rodeleros** = `Rodelero` real. Tiene columna NATIVA propia en el Barracks real (columna
  2, `protoy.xml`) — solo se habilitó (`Enable`), sin `CommandAdd`.
- **Highlander** = `HOSHighlander` (88889201), clon de `MercHighlander` real SIN el
  mecanismo de mercenario (quitados `Mercenary`/`FortressMercenary`/`LogicalTypePickableMerc`/
  `LogicalTypePickableMercOutlaw`) — mismo patrón que `HUNHajduk`/`HUNCrabat`/`HUNPandur`.
  Stats/costo (200 oro) idénticos al real. Columna 7 (libre), `<train>` estático (proto 100%
  propio). Sonido: `hoshighlander_snds.xml` plano, reusa `ScottishHighlander*` real
  (universal, sin `civlogic`).

## Establo
- **Húsar** y **Lancero** = `Hussar`/`Lancer` reales, habilitados explícitamente (roster
  europeo estándar).
- **Conquistador** = `ypNatMercConquistador` real (variante mercenaria del Conquistador
  nativo/jesuita `ypNatConquistador`). Sin columna nativa en el Establo (solo la tiene en
  `TradingPost`) — agregado vía `CommandAdd` a la columna 7 (libre).

## Fundición (ArtilleryDepot)
- **Lanzador de Fuego** = `deHoopThrower` real (unidad EXCLUSIVA de Malta, no
  `ypFlameThrower` asiático usado en una versión anterior por error de investigación). Match
  perfecto encontrado después: el string real de `deHoopThrower` (locid 124564) dice
  literalmente **"Lanzador de fuego"** — es el nombre real y correcto tal cual, no una
  traducción aproximada. Ya viene `Enabled` por `DEAge0Maltese`, ya tiene columna NATIVA en
  `ArtilleryDepot` (columna 0, `protoy.xml`) y sus mejoras reales
  (`DEVeteranHoopThrowers`/`DEGuardHoopThrowers`/`DEImperialHoopThrowers`) ya están
  `obtainable` — cero trabajo extra, sin `SetName` ni `CommandAdd`.

## Sonido — bug de civlogic corregido (mismo patrón que TODAS las civs nuevas del mod)
`Settler` y `Hussar` (ambos reales, heredados sin tocar) tienen `<civlogic>` en sus archivos
reales y **`DEMaltese` real YA tenía su propia rama** (Malta real usa
`DEMalteseSettlerMaleSelect`/etc. para el Colono, y — dato curioso — presta la voz HÚNGARA
`DEHungarianHussarSelect`/etc. para su Húsar). Como agregar una rama nueva apuntando a un
soundset vanilla por nombre no funciona en juego, se registraron copias `MMDEMalteseSettlerMale*`/
`MMDEHungarianHussar*` en `soundsetsde.mods.xml` (wavs reales copiados a `sound/mm/`) y se
agregó la rama `HOSHospitalarios` en `settler_snds.mods.xml` + un `hussar_snds.mods.xml`
nuevo. `Rodelero`/`Lancer`/`ypNatMercConquistador`/`deHoopThrower` son universales (sin
`civlogic`) — no necesitaron nada.

## Deuda técnica / pendiente
- Sin confirmar en juego: que la civ aparece en el selector, que Morgan Black se ve/suena
  correcto, que el roster del Cuartel/Establo/Fundición no tiene duplicados, y que el bono de
  curación idle de Malta (`LogicalTypeMalteseCivBonusHealsWhenIdle`) sigue funcionando para
  las unidades heredadas.
- El `Rollovertextid`/nombre de Conquistador (`ypNatMercConquistador`) es genérico (escrito
  para esta civ) — no se investigó si hay un nombre/rollover real más específico en otro
  idioma/contexto del juego. Lanzador de Fuego ya no tiene este pendiente (nombre real
  confirmado, ver Fundición arriba).
- Confirmados por el usuario (2026-09-11): roster de Cuartel/Establo correcto tal cual;
  Fundición corregida a `deHoopThrower` (real de Malta) en vez de `ypFlameThrower` (asiático).
