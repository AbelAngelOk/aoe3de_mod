# Rumania (`ROURomania`)

**Clon de**: Rusos (`Russians`). **IDs**: 88888xxx. **Agregada**: v6.8, ampliada fuerte en v8.0.
Techs `ROU*` delegan en los reales de Rusia. Reusa la bandera real de Rumania
(`objects\flags\romanian`, ya existe por la revolución `DERevRomania`) con buttonset ruso.

## Identidad
Civ normal (sin revolución). Sus 3 unidades propias son en realidad reskins de protos
genéricos usados por la revolución real rusa a Rumania, con nombres propios.

## Audio de Colono/Explorador (v8.0)
`ROURomania` no tenía rama en `settler_snds.mods.xml`/`explorer_snds.mods.xml` (mismo bug de
todas las civs nuevas de este mod) → quedaban mudos. Corregido registrando
`MMRussianSettlerMale*`/`MMRussianExplorer*` en `soundsetsde.mods.xml` con los `.wav` reales
rusos copiados a `sound/mm/`.

## Blocao
- **Modelo del Dorobant** (v8.0, EXPERIMENTAL): el animfile real compartido
  (`colonial_militia.xml`, base de `xpColonialMilitia`) resuelve el skin de la revolución con
  `<logic type="RevolutionCiv">` clave `derevromania` (materialvariant 4 + gorro alto
  dedicados, `units\revolution\dorobant\*`) — Rumania, al ser civ normal, nunca activa esa
  rama. Se creó un animfile propio (`art/units/infantry_ranged/roudorobant/roudorobant.xml` +
  `roudorobant_hats.xml`) con esa rama fija sin condición, y `ROUDorobant` apunta ahí en vez
  del `colonial_militia.xml` genérico. Sin confirmar en juego si `art/` es overrideable por el
  mod (mismo patrón y misma incertidumbre que `FINKarelianJaeger`).
- **Strelet → "Seimen"**: `SetName` del proto real dentro de `ROUAge0` (tech exclusiva de
  Rumania — no filtra a Rusia real, que también usa `Strelet`).
- **Poruchik (`deRussianHalberdier`) → "Vânător"**: mismo mecanismo.
- **Nombres de las mejoras de Streltsy/Poruchik**: las mejoras reales
  (`VeteranStrelets`/`GuardStrelets`/`ImperialStrelets`,
  `DEVeteranRussianHalberdiers`/`DEGuardRussianHalberdiers`/`DEImperialRussianHalberdiers`)
  son compartidas con Rusia real — no se puede renombrar su `SetName` directo sin afectar a
  Rusia. Se clonaron 6 techs propias con los mismos stats/prereqs y nombre acorde
  (`ROUVeteranSeimen`/`ROUGuardSeimen`/`ROUImperialSeimen`,
  `ROUVeteranVanator`/`ROUGuardVanator`/`ROUImperialVanator`); las reales quedan
  `unobtainable` para Rumania y las 6 nuevas `obtainable`, en las mismas columnas 0/3 del
  Blocao.
- **Tecnología equivalente para Dorobant y Hajduk**: Dorobant (100% propio) suma 3 techs
  nuevas (`ROUVeteranDorobant`/`ROUGuardDorobant`/`ROUImperialDorobant`). Hajduk (`HUNHajduk`,
  compartido con Hungría/HOT/HGE) reutiliza las mejoras húngaras YA EXISTENTES
  (`HUNVeteranHajduk`/`HUNGuardHajduk`/`HUNImperialHajduk`), solo marcadas `obtainable` para
  Rumania — mismo patrón multi-civ que el resto del mod, no clones nuevos.
- **Costo del lote de Dorobant**: 40 comida + 10 oro c/u → lote de 4 (`<blocktrain>` nativo,
  `civmods.xml`) = **160 comida + 40 oro**. Editado directo en el proto (100% exclusivo de
  Rumania, antes era 40 comida + 10 madera).
- **Costo del lote de Hajduk**: reasignado SOLO para Rumania a 97.5 oro c/u vía `Cost
  relativity="Assign"` en `ROUAge0` (sin tocar el proto compartido) → lote de 4 = **390 oro**.
- **Audio del Dorobant**: usaba por error `RussianSettlerMaleSelect/Acknowledge/Attack`
  (soundset de COLONO). Corregido a `RomanianMilitarySelect/Acknowledge/Attack` — el mismo
  soundset real (vanilla) que ya usa correctamente `HUNHajduk`.

## Establo
- **Cosaco → "Calaras"**: `SetName` de `Cossack` real dentro de `ROUAge0`.
- **Crabat en la 4ª columna**: `HUNCrabat` (compartido con Hungría/HOT/HGE, columna nativa 1)
  reposicionado a la columna 3 (4ª) SOLO para Rumania vía `CommandRemove`+`CommandAdd` en
  `ROUAge0` — no se puede editar su columna estática sin mover el botón también para
  Hungría/HOT/HGE.
- **Jinete Arquero de Valaquia en la 2ª columna**: `ROUWallachianArcher` (100% propio) movido
  a columna 1 (2ª), editado directo en su `<train>` estático (sin riesgo, no es compartido).
  80% de sus stats reales hasta Edad IV (`ROUIndustrialize` sube a 100%).
- Dragón Roshior (`ROURoshiorDragoon`, 100% propio) queda en columna 2 para no chocar con las
  dos anteriores. Visible desde el inicio, entrenable solo desde Edad IV (`allowedage=3`).

## Jinete Arquero de Valaquia
Se quitó el bono de daño x2 contra `AbstractArtillery` en sus 3 acciones (`BowAttack`/
`VolleyRangedAttack`/`ChargeAttack`) — editado directo en el proto (100% exclusivo).

## Dragón Roshior
Bonos de daño rebalanceados en sus 3 acciones (`DefendRangedAttack`/`MeleeHandAttack`/
`StaggerRangedAttack`), editados directo en el proto:
- `AbstractArtillery`: x2 → **x3**.
- `AbstractHeavyCavalry`: x3 → **x2**.
- `AbstractHeavyInfantry` (infantería de choque cuerpo a cuerpo, ej. Poruchik/Vânător): **x0**
  (nueva, no existía antes).

## Políticos de avance de edad (v8.0, EXPERIMENTAL)
Los 5 políticos reales de Rusia son las TECHS DE EDAD mismas (`SetAge`+`FreeHomeCityUnit`),
compartidas con Rusia real — no se pueden editar directo. Envíos pedidos y cómo quedaron:

| Político | Envío real (Rusia) | Envío pedido (Rumania) | Cambio necesario |
|---|---|---|---|
| El Rastreador (`PoliticianScoutRussian`) | 5 Cossack | 4 Calaras | Cantidad (5→4) — clonado `ROUPoliticianScout` |
| El Aventurero (`PoliticianAdventurerRussian`) | 17 Strelet | 17 Seimen | Ninguno: Strelet ya se renombra a Seimen |
| El Mariscal de Caballería (`PoliticianCavalierRussian`) | 7 Cossack | 7 Calaras | Ninguno: Cossack ya se renombra a Calaras |
| El Mosquetero Real (`PoliticianMusketeerRussian`) | 13 `deRussianMusketeer` | 13 Dorobant | Unidad — clonado `ROUPoliticianMusketeer` |
| El Ministro de Guerra (`PoliticianWarMinisterRussian`) | 7 Oprichnik | 7 Dragón Roshior | Unidad — clonado `ROUPoliticianWarMinister` |

Los 3 que cambian (Rastreador/Mosquetero Real/Ministro de Guerra) se clonaron completos
(mismo `SetAge`/costo/ícono/rollover) apuntando a la unidad/cantidad nueva; los reales quedan
`unobtainable` para Rumania. Depende de que el motor arme la pantalla de elección de edad
enumerando techs `OBTAINABLE` con flag `AgeUpgrade`+`SetAge` en vez de una lista fija por
civ — no se encontró otro mecanismo de registro para confirmar esta asunción.

## Granadero
`Grenadier` (real, compartido con media docena de civs) no tenía rama de sonido para Rumania
→ mudo. Se le dio la voz del Crabat (`CroatianOutlawSelect/Acknowledge/Attack`, la misma que
ya usa `HUNCrabat`): copias `MMCroatianOutlaw*` registradas en `soundsetsde.mods.xml` +
`grenadier_snds.mods.xml` nuevo con la rama `ROURomania` (agregar civlogic nuevo a un archivo
que ya tenía civlogic apuntando a un soundset vanilla por nombre no suena en juego — hace
falta el registro `MM` + wav copiado, igual que siempre).

## Centro Urbano
Sin revoluciones: `DERevolutionRomania` marcada `unobtainable` en `ROUAge0` — Rumania es una
civ normal, no revolucionaria.

## Deuda técnica / pendiente
- Modelo del Dorobant y los 3 políticos clonados: EXPERIMENTAL, sin confirmar en juego.
- Confirmar visualmente Blocao/Establo sin duplicados y que el audio nuevo (Colono,
  Explorador, Dorobant, Granadero) realmente suena.
