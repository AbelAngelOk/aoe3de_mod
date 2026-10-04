# Brasil (propuesta, sin implementar)

**Base**: metrópoli base Portugueses.

## 🔎 Hallazgo clave (investigación 2026-09-09) — ⚠️ discrepancia
Existe `DERevolutionBrazil` real (dbid 6421, displaynameid 80839 = **"Brasil"**,
`revolutionciv=DERevBrazil`, bandera real `objects\flags\brazilian`, `Flag_Brazilian.png`).
**Su mecánica real es completamente distinta al pedido**: renombra `xpColonialMilitia` a
**"Voluntario da Patria"** (string 90318), +50% HP/daño/costo/trainpoints, y lo produce GRATIS
de forma continua desde el Centro Urbano cada vez que "se pierden" aldeanos (mecánica
`FreeHomeCityUnitByUnitCount` ligada a `AbstractDoubleVillager`) — nada que ver con
Fuzileiro/Caçador/Cavalaria Ligeira/Dragones Independientes/Jagunços.

`DEHCREVHonorGuard` y `DEHCREVJaguncos` (las 2 techs citadas en el pedido) **SÍ existen como
nombres reales** en `techtreey.xml` (líneas ~83486 y ~83328 respectivamente) pero no se
investigó su contenido en esta pasada — antes de implementar, revisar qué otorgan
exactamente (es probable que sean cartas/mecánicas adicionales sobre la revolución base, no
la revolución en sí).

**Recomendación**: si el diseño pedido (Fuzileiro/Caçador/Cavalaria Ligeira/Dragones/Jagunços)
es lo que se quiere, esta civ probablemente deba construirse como una civ NORMAL clon de
Portugueses (reusando solo la bandera real de `DERevBrazil` y el patrón de límite de Centros
Urbanos), sin la mecánica de revolución/Voluntario da Patria real — mismo enfoque que tomó
Rumania frente a su revolución real.

## General
- Límite de 11 Centros Urbanos.
- Los envíos de metrópoli llegan casi al instante (⚠️ sin mecanismo real identificado —
  posible reducción del `shipmenttime`, no investigado a fondo).

## Cuartel
- Fuzileiro: soldado con voz de Mosquetero portugués.
- Caçador.

## Establo
- Cavalaria Ligeira: Húsar.
- Dragones Independientes (`DEHCREVHonorGuard` — nombre confirmado real, contenido pendiente).
- Jagunços (`DEHCREVJaguncos` — nombre confirmado real, contenido pendiente).

## Pendiente de definir antes de implementar
- Investigar el contenido real de `DEHCREVHonorGuard` y `DEHCREVJaguncos`.
- Decidir si se usa la mecánica de revolución real (`DERevolutionBrazil`/Voluntario da
  Patria) o se construye como civ normal con el roster pedido (ver recomendación arriba).
- Rango de IDs propio.
- Confirmar el mecanismo real de "envíos casi instantáneos".
- Confirmar proto real de Fuzileiro/Caçador (¿clones de Musketeer/Skirmisher portugueses, o
  ya existen como protos reales?).
