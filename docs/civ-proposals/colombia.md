# Colombia — ✅ IMPLEMENTADA (v12.0)

**Ver el estado real en [`docs/civs/11-colombia.md`](../civs/11-colombia.md).** Todo lo de
más abajo es el registro histórico de la propuesta original.

## 🔎 Hallazgo clave (investigación 2026-09-09)
Confirmadas **dos** variantes reales: `DERevolutionColombia` (dbid 6424) y
`DERevolutionColombiaPortuguese` (dbid 6514) — mismo `displaynameid 80842` = **"Gran
Colombia"**, misma `revolutionciv=DERevColombia` (civs.xml, bandera real
`objects\flags\colombian`, `Flag_Colombian.png`, botón `santanderFlagBtn` — referencia a
Francisco de Paula Santander). La existencia de dos variantes confirma que hay (al menos) dos
civs reales distintas que pueden revolucionar a Colombia — la "normal" y la "Portuguese"
(probablemente España vs Portugal como origen).

**"Guardias Independientes" — nombre EXACTO ya real, casi calcado del pedido**: la tech
convierte a los colonos en `Musketeer` (`InitiateRevolution`) renombrado vía `SetName` a la
string real **80965 = "Guardia independiente"**. Buffs: +10%/+15% HP y daño (según variante),
-10% velocidad, bono x1.5/x1.3 contra caballería/infantería ligera, y activa
`VeteranMusketeers`. Envía 2 Acorazados (`xpIronclad`).

**"Simón Bolívar" — confirmado como asset real, pero NO como Explorador ni exclusivo de
Colombia.** `deREVBolivar` (protoy.xml, `displaynameid 34107` = "Bolívar") es una unidad tipo
`Hero` (1500 HP, infantería, NO tiene `LogicalTypeExplorer`) que se otorga vía una carta de
Home City GENÉRICA de revolución, **`DEHCREVNationalHero`** (dbid 6516, string 80969 = "Héroe
nacional") — esta misma carta también aparece en `DERevolutionPeru`, así que Bolívar no es
único de Colombia en los datos reales. Para usarlo como reemplazo de Explorador hay que
armarlo como proto nuevo (reusando el modelo/ícono/animación de `deREVBolivar`), no hay un
Explorador-Bolívar ya hecho.

## Inicio
- Sin Explorador. En su lugar: **Simón Bolívar** (ver hallazgo arriba — asset real
  reutilizable, pero requiere armar un proto nuevo tipo Explorador con ese modelo).

## Cuartel
- Guardias Independientes (mosqueteros más fuertes y más lentos — variante de Musketeer, ver
  hallazgo arriba: nombre y mecánica YA existen reales, solo falta decidir si se clona
  `DERevolutionColombia` tal cual o se rehace como civ normal sin `InitiateRevolution`, mismo
  dilema que Argentina con `DERevolutionArgentina`).
- Fusileros: Guerrilleros.

## Establo
- Húsares: **existen** (el usuario aclara que la civ real de Colombia ya los tiene/usa).
- Llaneros: **existen** (ídem).
- Lanceros: lanceros españoles con otra skin más informal, "quizás de charros" (⚠️ no
  identificado en esta pasada — confirmar proto/skin real antes de implementar).

## Pendiente de definir antes de implementar
- ~~Revisar `DERevolutionColombia` real primero~~ → **hecho, ver hallazgo arriba**. Decidir
  si la civ nueva CLONA la mecánica de revolución (`InitiateRevolution` sobre Musketeer,
  igual que Argentina clona `DERevolutionArgentina`) o si es una civ "normal" con Guardia
  Independiente como unidad de Cuartel entrenable sin bloqueo de edad (igual que Rumania optó
  por ser civ normal en vez de revolucionaria).
- Civ base real a clonar: candidatos **España** (`DERevolutionColombia`) o **Portugal**
  (`DERevolutionColombiaPortuguese`) — confirmar cuál pidió el usuario, o si se quiere ofrecer
  ambas variantes.
- Rango de IDs propio.
- Proto real del lancero "estilo charro" (sin identificar).
- Decidir cómo armar el Explorador "Simón Bolívar" (proto nuevo basado en `deREVBolivar`).
