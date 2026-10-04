# Francia Napoleónica — ✅ IMPLEMENTADA (v14.0)

**Ver el estado real en [`docs/civs/13-francia-napoleonica.md`](../civs/13-francia-napoleonica.md).**
Todo lo de más abajo es el registro histórico de la propuesta original.

**Base implícita**: Francia (`DEFrench`).

## 🔎 Hallazgo clave (investigación 2026-09-09)
**"Francia Napoleónica" ya es una revolución/identidad real**: `DERevFranceNE` (civs.xml,
displaynameid 200134 = **"Franceses napoleónicos"**, exacto). El proto real detrás de
"Sansculotte" es el **`Coureur` renombrado**: la tech real de esa transformación (parece ser
`DERevolutionFrance`, dbid 10336 — nombre de tech distinto al de la civ-flag `DERevFranceNE`,
confirmar la relación exacta entre ambos antes de implementar) hace `SetName proto="Coureur"
newname="125348"` = **"Sansculotte"**, y lo convierte de `AbstractVillager` a
`AbstractInfantry`/`AbstractGunpowderTrooper`/`Military` (deja de ser economía, pasa a ser
tropa) + `BuildBounty/KillBounty=8` + `Cost(Food) -20 Absolute`.

**No se encontró ninguna tech de "Mercado" que EXCLUYA a Sansculotte de sus bonos** — lo que
sí existe es un patrón real ANÁLOGO: dos "shadow techs" que ANULAN un bono que el Sansculotte
recibiría de otra fuente:
- `DEREVSansculotteMarcoPoloShadow` (prereq: revolución francesa + `DEHCMarcoPoloVoyages`
  activas): reduce la velocidad del Coureur a 0.90 — contrarresta el bono de velocidad que
  esa carta daría normalmente.
- `DEREVSansculotteNorthwestShadow` (prereq: revolución francesa + `HCNorthwestPassage`):
  reduce la velocidad a 0.85, mismo patrón.

Si "Francia Napoleónica" necesita excluir a Sansculotte específicamente de techs de MERCADO
(no de cartas de Home City como las de arriba), no hay precedente exacto — el patrón a
replicar sería el mismo: una `<tech>` "shadow" con `prereqs` = revolución activa + la tech de
Mercado en cuestión activa, que anula/revierte el bono correspondiente sobre `Coureur`.

## Sansculottes
- Uso general: como no están beneficiados por las techs de mercado que se quitan del
  Mercado, el límite de Sansculottes es **70**.
- Stats por defecto = los de Edad IV. Escalado hacia abajo en edades tempranas (mismo patrón
  de escalado por edad ya usado en este mod, ver Bersagliere/Jinete Arquero de Valaquia):
  - Edad III: **-25%**.
  - Edad II: **-50%**.
  - Edad I: equivalente a los Coureurs de Bois.

## Granaderos
- Pueden recolectar recursos (habilidad económica agregada a una unidad militar — mismo
  patrón ya usado en este mod para el Gaucho de Argentina, que puede construir Corrales).

## Establo
- Fusilero Montado habilitado como unidad "nativa" (⚠️ aclarar qué significa "nativa" acá —
  ¿mercenario/native-style, o solo "disponible por defecto"?), con:
  - Costo de población: 3.
  - Costo de recursos: 125 alimento + 175 monedas.

## Pendiente de definir antes de implementar
- Confirmar la relación exacta entre `DERevFranceNE` (civ-flag) y `DERevolutionFrance` (tech
  que renombra Coureur→Sansculotte) — pueden ser la misma revolución vista desde dos ángulos,
  o dos cosas relacionadas pero distintas.
- Rango de IDs propio.
- Confirmar qué techs de Mercado se excluyen exactamente para Sansculottes (sin precedente
  exacto encontrado — modelar por analogía a las shadows de Marco Polo/Northwest Passage).
- Aclarar "unidad nativa" para el Fusilero Montado.
