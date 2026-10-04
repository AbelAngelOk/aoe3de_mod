# Chile (`CHLChile`)

**Clon de**: España (`Spanish` — el mismo real `Age0Spanish` marca `DERevolutionChile`
obtainable, confirmando que Chile revoluciona desde España en los datos reales). **IDs**:
888812xxx. **Agregada**: v13.0. Techs `CHL*` delegan en las reales de España. Home city
(`homecitychlmin.xml`) copia literal de `homecityspanish.xml`. Reusa la bandera/buttonset
REALES de la revolución de Chile (`DERevChile`, `objects\flags\chilean`, `oHigginsFlagBtn` —
referencia a Bernardo O'Higgins).

## Identidad
Civ normal (sin `InitiateRevolution`). Explorador normal (sin reemplazo, a diferencia de
Colombia/Estados Berberiscos).

## Cuartel
- **Soldado Mexicano** = `deSoldado` real (SetName propio dentro de `CHLAge0` — Argentina
  también usa este mismo proto como "Patricio" con su propio `SetName` en `ARGAge0`; no
  colisiona, cada civ tiene su propia tech de edad exclusiva).
- **Guerrillero** = `Skirmisher` real, nombre español default ya correcto.

## Establo
- **Húsar de la Muerte** = `Hussar` real. Réplica EXACTA del efecto real de
  `DERevolutionChile`: activa `VeteranHussars`/`GuardHussars` directo (sin necesidad de
  investigar nada), daño x2, ícono real dedicado `deIconREVChileanHussar`. Nombre real ya
  correcto (locid 80935). Se omitieron las partes puramente económicas/de revolución del
  efecto real (bono de Plantación, límite de Colono, envío gratis de 8 Húsares) — no pedidas
  explícitamente.
- **Cazador a Caballo** = `Dragoon` real, con escalado por edad (80% en Edad II vía
  `CHLAge0`, 100% en Edad IV vía `CHLIndustrialize` — mismo patrón que el Bersagliere de
  Holanda Italiana/Jinete Arquero de Valaquia de Rumania) + el bono x2 vs
  `AbstractHeavyCavalry` de la carta real `DEHCREVHorseHunters` horneado directo y permanente
  (en vez de depender de esa carta).

## Fundición
**Granaderos** = `Grenadier` real, habilitado directo.

## Sonido
`Settler`/`Hussar`/`Dragoon`/`Skirmisher`/`Grenadier` (reales, heredados) sin rama para esta
civ — se reusaron los mismos soundsets que ya usa la rama "Spanish" real en cada uno
(`MMSpanishSettlerMale*`, `MMSpanishLightCavalry*` para Húsar, `MMSpanishDragoon*` para
Dragón y también para Guerrillero —el Skirmisher español real presta esa misma voz—,
`MMSpanishCannon*` para Granadero). Casi todos estos soundsets YA estaban registrados por
Argentina/Colombia; solo `MMSpanishCannon*` fue nuevo. `deSoldado` es universal (sin
civlogic).

## Deuda técnica / pendiente
- Sin confirmar en juego: que la civ aparece en el selector, que el Húsar de la Muerte se ve/
  suena con su ícono dedicado, y que el Cuartel/Establo/Fundición no tienen botones
  duplicados.
- No se agregaron los bonos económicos de la revolución real (Plantación/límite de Colono) —
  el pedido del usuario no los mencionaba explícitamente, quedan como posible ampliación.
