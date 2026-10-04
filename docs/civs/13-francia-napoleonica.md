# Francia Napoleónica (`FRAFranceNapoleonica`)

**Clon de**: Francia (`French`). **IDs**: 888813xxx. **Agregada**: v14.0. Techs `FRA*` delegan
en las reales de Francia (`Age0French`...`PostImperialFrench`). Home city
(`homecityframin.xml`) copia literal de `homecityfrench.xml`. Reusa la bandera real de
"Franceses napoleónicos" (`DERevFranceNE`, `objects\flags\french_revolution_ne`, ya existe en
el juego base) con el buttonset de Francia (`DERevFranceNE` no define uno propio).

## Identidad
Civ normal (sin `InitiateRevolution`). El colono real de Francia es **`Coureur`** (no
`Settler`) — la transformación a Sansculotte afecta directamente a la fuerza de trabajo
económica de la civ, mismo que la revolución real.

## 🔎 Hallazgo importante
`DERevolutionFranceNE` (la tech ligada a la bandera "Franceses napoleónicos") es una
**sub-revolución posterior** sobre `DERevolutionFrance` (prereq: `DERevolutionFrance` activa
+ `Fortressize`) — bloquea las mejoras Imperiales y activa contenido de "era napoleónica"
avanzada (Bourbon, cañón Napoleón). La mecánica de Sansculotte que pidió el usuario viene de
la revolución BASE (`DERevolutionFrance`), no de esta sub-revolución — se usó la bandera de
`DERevFranceNE` solo por la identidad "napoleónica" pedida, pero el contenido de juego es el
de la revolución base.

## Sansculotte (Coureur)
Réplica del efecto real de `DERevolutionFrance` sobre `Coureur` — convierte al colono en una
unidad militar híbrida (mantiene capacidad de recolectar a tasas reducidas, gana ataque de
fusil/culatazo/asedio, `BuildBounty`/`KillBounty`=8, -20 comida de costo, -45 HP absolutos,
+60% trainpoints reducido... TODO el efecto real fue replicado tal cual, SIN
`InitiateRevolution` ni el reemplazo de `NativeScout`→`deRevolutionaryScout` (partes de
mecánica de revolución, no de identidad de la unidad). Escalado por edad (pedido explícito):
- **Edad I** (`FRAAge0`): sin cambios — Coureur normal, economía pura.
- **Edad II** (`FRAColonialize`): transformación completa aplicada, con Hitpoints/Daño al
  **50%** (`BasePercent` encima de los valores absolutos del efecto real).
- **Edad III** (`FRAFortressize`): **75%**.
- **Edad IV** (`FRAIndustrialize`): **100%** (stats reales completas).
- Límite: **70** Sansculottes (`BuildLimit` en `FRAAge0`).

## Granaderos
`Grenadier` real, con habilidad de recolección agregada (`ActionEnable Gather` + `WorkRate`
sobre madera/mina/granja/caza/ganado) — mismo patrón que el Gaucho de Argentina con los
Corrales.

## Establo
**Fusilero Montado** = `FRAMountedRifleman` (888813201), clon de `deMercMountedRifleman` real
SIN el mecanismo de mercenario (quitados `Mercenary`/`IndustrialMercenary`/
`LogicalTypePickableMerc`/`LogicalTypePickableMercOutlaw`) — mismo patrón que Hajduk/Crabat/
Pandur/Highlander/Pirata. Costo y población propios pedidos (125 comida + 175 oro, 3 de
población, en vez de los reales 400 oro/4 población). Columna 4 (libre), `<train>` estático.

## Sonido
`Grenadier` (real, heredado) sin rama para esta civ — se reusó el mismo soundset que ya usa
la rama "French" real (`FrenchGrenadierSelect`/etc., copiado como `MM`). `Coureur` es
universal (sin `civlogic` — es el colono base de Francia, nunca necesitó nada). El Fusilero
Montado clonado reusa directo (sin registro `MM`) los soundsets `FrenchSkirmisher*` que ya usa
el real `deMercMountedRifleman` en su propio archivo plano.

## Deuda técnica / pendiente
- Sin confirmar en juego: que la civ aparece en el selector, que el Sansculotte realmente
  escala de fuerza por edad sin errores, y que sigue pudiendo recolectar recursos con el
  `SetUnitType` aplicado.
- No se investigaron techs de Mercado que excluyan a Sansculotte de sus bonos (mencionado en
  la propuesta original, sin precedente real encontrado) — no implementado.
- No se replicaron los bonos económicos/de Fortín de `DERevolutionFranceNE` (Bourbon,
  Factory `BuildLimit`=2, etc.) — son de la sub-revolución posterior, fuera del alcance del
  pedido original.
