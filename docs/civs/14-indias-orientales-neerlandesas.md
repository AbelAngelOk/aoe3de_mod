# Indias Orientales Neerlandesas (`IORDutchEastIndies`)

**Clon de**: Portugal (`Portuguese`). **IDs**: 888814xxx. **Agregada**: v15.0. Techs `IOR*`
delegan en las reales de Portugal (`Age0Portuguese`...`PostImperialPortuguese`). Home city
(`homecityiormin.xml`) copia literal de `homecityportuguese.xml`. Bandera real de Indonesia
(`DERevIndonesia`, `objects\flags\indonesian`); como `DERevIndonesia` no define
`homecityflagbuttonset` propio, se reusa el de Portugal (`portugueseFlagBtn`/`Large`).

## Identidad
Civ normal (sin `InitiateRevolution`). Base Portugal confirmada: `DERevolutionIndonesia`
aparece `obtainable` tanto en `Age0Dutch` como en `Age0Portuguese` en el juego real — ambas
bases son válidas; se usó Portugal por pedido explícito del usuario.

## Roster (6 unidades, todas protos reales reposicionados/renombrados, sin clones nuevos)
Todos los nombres/mecánicas vienen de `DERevolutionIndonesia` (dbid 6435, la revolución real
de Indonesia) o de mercenarios/nativos reales — se replicó el efecto de la revolución real
SIN `InitiateRevolution` ni el reemplazo de Explorer, quedando solo la identidad de cada
unidad.

- **Lancero Javanés** = `deREVJavaSpearman` (real de la revolución). String real
  (`displaynameid 80715`) ya decía "Lancero javanés" — reusado sin crear string nueva.
  `AddTrain` a `Barracks` (mismo mecanismo que usa el juego real para unidades de revolución
  en un building, en vez de `CommandAdd`).
- **Cetbang** = `deREVCetbang` (real de la revolución). String real (`displaynameid 80801`)
  ya decía "Cañón cetbang" — reusada. `AddTrain` a `ArtilleryDepot`.
- **Jawa** = `ypRepentantSmuggler` (mercenario real). Quitado el unittype `AbstractOutlaw`
  (único flag outlaw que tenía). Costo/población propios pedidos: 50 comida + 50 oro,
  población 2 (reales: 115 oro solo, población 4). `CommandAdd` a `Barracks` col.9.
- **Berkuda** = `deSaloonOutlawCossack` (nativo/outlaw real). Solo `Enable`+`SetName`+
  reposición — no se tocó su `Wanders`/`AbstractOutlaw` en detalle más allá de lo mínimo
  pedido.
- **Pemanah Kuda** = `ypWokouWaywardRonin` (mercenario real). Quitados los TRES unittypes
  outlaw que tenía (`AbstractOutlaw`, `LogicalTypePickableOutlaw`,
  `LogicalTypePickableMercOutlaw`).
- **Prajurit Kraton** = `ypNatChakram` (nativo real, `subciv="Udasi"`). El más simple: solo
  `Enable`+`SetName`+`CommandAdd` a `ArtilleryDepot` col.3 — sin cambios de costo/población
  (no pedidos), sin tocar `subciv`.

## Sonido
- **Colono** (`Settler`, real compartido): sin rama para `IORDutchEastIndies` en
  `settler_snds.xml` → mudo. Se agregó rama nueva en `settler_snds.mods.xml` reusando la voz
  de la rama Portuguese real, vía soundsets `MMPortugueseSettlerMale*` (9 soundsets, wavs
  copiados a `sound/mm/`).
- **Lancero Javanés** (`deREVJavaSpearman`): su archivo real solo tiene ramas `Dutch`/
  `Portuguese` → mudo para esta civ. Rama nueva en `derevjavaspearman_snds.mods.xml` (archivo
  creado) reusando `MMPortuguesePikeman*`.
- **Cetbang** (`deREVCetbang`): mismo caso, rama nueva en `derevcetbang_snds.mods.xml`
  (archivo creado) reusando `MMPortugueseFalconet*`.
- **Jawa/Berkuda/Pemanah Kuda/Prajurit Kraton**: los 4 protos base (`ypRepentantSmuggler`,
  `deSaloonOutlawCossack`, `ypWokouWaywardRonin`, `ypNatChakram`) no tienen `<civlogic>` en
  sus archivos de sonido reales (universales) — no necesitan ningún fix de sonido.

## Deuda técnica / pendiente
- Sin confirmar en juego: aparición en el selector, sonido de las 3 unidades corregidas,
  entrenamiento correcto desde `Barracks`/`ArtilleryDepot`.
- `deSaloonOutlawCossack` tiene en el juego real un mecanismo de "jinete desmontado"
  (`sharedselectionunittypes` → `deSaloonOutlawCossackRider`) que **no se implementó** — se
  trató como unidad estándar única, simplificación aceptada.
- `ypNatChakram` tiene `subciv="Udasi"` (unidad nativa) que no se investigó a fondo; existe
  riesgo (sin confirmar) de restricciones especiales de entrenamiento heredadas de unidades
  nativas, mismo patrón de duda ya señalado para `ypNatMercConquistador`/`ypNatConquistador`
  en Caballeros Hospitalarios.
