# Estados Berberiscos (`BARBerberiscos`)

**Clon de**: Otomanos (`Ottomans` — mismo patrón que Egipto). **IDs**: 888810xxx. **Agregada**:
v11.0. Techs `BAR*` delegan en las reales de Otomanos (`Age0Ottoman`...`PostImperialOttoman`).
Home city (`homecitybarmin.xml`) copia literal de `homecityottomans.xml`. Reusa la bandera
REAL de la revolución `DERevolutionBarbaryStates` (`objects\flags\spc_barbary`, ya existe en
el juego base) con buttonset de Otomanos (no tiene uno propio).

## Identidad
Casi todo el roster pedido resultó ser protos REALES de la propia revolución
`DERevolutionBarbaryStates`, con nombres reales ya correctos en español — muy poco trabajo de
`SetName`/strings nuevas necesario.

## Roster otomano heredado — deshabilitado (2026-09-11)
`Age0Ottoman` habilita por defecto todo el roster militar OTOMANO real (no exclusivo de esta
civ) junto con el roster propio de Berberiscos, quedando ambos mezclados en los mismos
edificios. Pedido explícito del usuario: "los de Estados Berberiscos no deben tener unidades
otomanas" — se deshabilitaron (mismo patrón que Argentina con `dePavisier`/`Pikeman`/
`Halberdier` de Italia):
- **Cuartel**: `Janissary` (Jenízaro), `deAzap` (Azap) + sus 6 mejoras.
- **Establo**: `deDeli` (Deli), `Spahi`, `CavalryArcher` (Arquero a Caballo) + sus 4 mejoras.
- **Fundición**: `deHumbaraci` (Humbaracı), `AbusGun` (Cañón Abus) + sus 6 mejoras.

## Inicio
Sin Explorador estándar: **`BARCorsairCaptain`** — clon completo del Explorador real (mismo
build list: TradingPost/TownCenter/FieldHospital) con el modelo/ícono real del corsario
histórico Oruç Reis (`deREVCorsairCaptain`, `units\spc\oruc_reis\*`) y su nombre real
reutilizado directo (locid 80712 = "Capitán corsario", sin `SetName`). Sonido:
`barcorsaircaptain_snds.xml` plano, reusa `MMSahin*` (ya registrados por Egipto — el real
`deREVCorsairCaptain` usa los mismos soundsets `Sahin*` que el Explorador otomano).

## Cuartel
- **Pirata** = `BARPirate` (888810201), clon de `SaloonPirate` real (mercenario de Tavern)
  SIN el mecanismo de forajido (quitados `AbstractOutlaw`/`LogicalTypePickableOutlaw`/
  `LogicalTypePickableMercOutlaw`) — mismo patrón que Hajduk/Crabat/Pandur/Highlander. Nombre
  real reutilizado (locid 46130 = "Pirata"). Columna 8 (libre), `<train>` estático.
- **Guerrero Berberisco** = `deREVBarbaryWarrior` real. Sin columna nativa en el Barracks
  (solo se usa vía el mecanismo de revolución) — agregado por `CommandAdd` a la columna 9.
  `AllowedAge` reasignado a 0 (el real es 3, pensado para una revolución tardía; para esta
  civ normal se quiere disponible desde el inicio). Nombre real ya correcto (locid 80662).
- **Tirador Corsario** = `deAllegianceBarbaryMarksman` real. Sin columna nativa en el
  Barracks (solo en Tavern) — agregado por `CommandAdd` a la columna 10. Nombre real ya
  correcto (locid 80648).

## Establo
- **Jinete del Magreb** = `deBarbaryCavalry` real ("Jinete tribal" en el juego base) —
  **columna NATIVA propia en el Establo (columna 0)**, solo se habilitó y renombró, sin
  `CommandAdd`.
- **Jinete Makhzen** = `deBedouinHorseArcher` real ("Jinete arquero beduino" en el juego
  base) — columna NATIVA propia (columna 1), mismo tratamiento.
- Ambos son protos reales de la propia revolución de Estados Berberiscos, ya pensados para
  este building — coincidencia perfecta con el pedido, solo renombrados a los nombres de
  sabor pedidos (`SetName`, seguro porque vive dentro de `BARAge0`, exclusiva de esta civ).

## Sonido
`Settler` (real, heredado) tiene `<civlogic>` sin rama para esta civ — se agregó la rama
`BARBerberiscos` reusando los soundsets `MMOttomanSettlerMale*` YA registrados por Egipto (sin
copiar ningún `.wav` nuevo). `deBarbaryCavalry`/`deBedouinHorseArcher`/`deREVBarbaryWarrior`/
`deAllegianceBarbaryMarksman` son universales (sin `civlogic`) — no necesitaron nada.
`SaloonPirate` (base de `BARPirate`) usa `<techlogic>` con fallback universal
(`BarbaryCorsairSelect`/etc.) — se reusó directo en `barpirate_snds.xml` plano.

## Deuda técnica / pendiente
- Sin confirmar en juego: que el Capitán Corsario se ve/suena bien, y que el Cuartel/Establo/
  Fundición ya no muestran ningún botón otomano tras el fix de 2026-09-11.
- No se investigaron a fondo las 4 variantes "shadow" de `DERevolutionBarbaryStates`
  (Portuguesa/Italiana/Maltesa) más allá de la Otomana — quedan como posible contenido
  adicional si se quisiera ampliar el roster más adelante (ver
  `docs/civ-proposals/estados-berberiscos.md` para el detalle de cada shadow).
