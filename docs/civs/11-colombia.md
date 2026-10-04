# Colombia (`COLColombia`)

**Clon de**: España (`Spanish`). **IDs**: 888811xxx. **Agregada**: v12.0. Techs `COL*` delegan
en las reales de España (`Age0Spanish`...`PostImperialSpanish`). Home city
(`homecitycolmin.xml`) copia literal de `homecityspanish.xml`. Reusa la bandera/buttonset
REALES de la revolución de Colombia (`DERevColombia`, `objects\flags\colombian`,
`santanderFlagBtn`, ya existen en el juego base).

## Identidad
Civ normal (sin `InitiateRevolution`, mismo criterio que Rumania/Argentina). Casi todo el
roster reusa nombres REALES ya correctos, sin necesidad de `SetName` ni strings nuevas:
"Guardia independiente" (locid 80965), "Guerrillero" (locid 22956, nombre español default de
`Skirmisher`), "Llanero" (locid 80977), "Bolívar" (locid 34107).

## Inicio
Sin Explorador: **`COLBolivar`** — clon completo del Explorador real (mismo build list:
TradingPost/TownCenter/FieldHospital) con el modelo/ícono real del héroe de campaña Simón
Bolívar (`deREVBolivar`, `units\spc\bolivar\*`) y su nombre real reutilizado directo (sin
`SetName`). Sonido: `colbolivar_snds.xml` plano, reusa los soundsets reales `Bolivar*`
(dedicados, universales).

## Cuartel
- **Guardia Independiente** = `Musketeer` real, con los mismos buffs que le da la tech real
  `DERevolutionColombia` (+10% HP/daño, -10% velocidad, bonos x1.5/x1.3 vs caballería/
  infantería ligera) pero SIN `InitiateRevolution` ni el envío de Acorazados (específicos de
  la mecánica de revolución). Nombre real ya correcto (locid 80965). Mejoras propias
  (`COLVeteranGuardiaIndependiente`/`GuardGuardiaIndependiente`/`ImperialGuardiaIndependiente`)
  clonadas de `VeteranMusketeers`/`RGRedcoats`/`ImperialMusketeers` reales — no se pueden
  activar directo (compartidas con cualquier civ que también use Musketeer real).
- **Guerrillero** = `Skirmisher` real, habilitado directo (nombre español default ya es
  "Guerrillero", sin `SetName`).

## Establo
- **Llanero** = `deREVLlanero` real. Réplica exacta del patrón de la carta real
  `DEHCREVLlaneros`: entrenable directo en el Establo (`AddTrain`), puede construir Corrales
  y recolectar de las vacas, 1 población, 120 comida/0 oro, bono x5 vs Llama. Nombre real ya
  correcto (locid 80977).
- **Lancero** = `deChinaco` real ("lancero de estilo charro" pedido — el Chinaco es
  mexicano/informal, encaja con la descripción). Columna NATIVA propia en el Establo
  (columna 1) — solo `Enable`+`SetName`, sin `CommandAdd`.
- Húsar: heredado por defecto de España (roster europeo estándar), sin cambios.

## Sonido
`Settler`/`Musketeer`/`Skirmisher` (reales, heredados) tienen `<civlogic>` sin rama para esta
civ. Reusan directo los soundsets que YA usa la rama "Spanish" real en cada uno:
`MMSpanishSettlerMale*` (ya registrados por Argentina), `MMSpanishMusketeer*` (nuevo),
`MMSpanishDragoon*` (nuevo — dato curioso: el Guerrillero/`Skirmisher` español real PRESTA la
voz del Dragón español en vez de tener una propia). `deREVLlanero`/`deChinaco` son
universales (sin civlogic) — no necesitaron nada.

## Deuda técnica / pendiente
- Sin confirmar en juego: que la civ aparece en el selector, que Bolívar se ve/suena bien, y
  que el Cuartel/Establo no tienen botones duplicados.
- No se investigó la variante `DERevolutionColombiaPortuguese` (Portugal como base
  alternativa) — se usó España por ser la variante "principal"/no sufijada.
