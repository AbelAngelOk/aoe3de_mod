# Argentina (`ARGArgentina`)

**Clon de**: Italia (`DEItalians`). **IDs**: 88883xxx. **Agregada**: v5.0, corregida
v5.1/v6.1/v6.2/v9.0. Techs `ARG*` delegan en los reales de Italia. Reusa TODOS los assets
reales de la revolución real `DERevolutionArgentina`/`DERevArgentina` (bandera, botón "San
Martín") — Argentina ya es una revolución real de Italia en el juego base, con sus propias
unidades `deREVGaucho`/`deREVGranadero`.

## Identidad
Gauchos + Iglesia común (no Basílica) + corrales con vacas en vez de corderos.

## Iglesia
Italia reemplaza `Church` por su propia Basílica (`deBasilica`) y nunca habilita `Church`.
Argentina hace lo opuesto: deshabilita `deBasilica`, habilita `Church` + sus 7 techs estándar
(Italia nunca las marca `obtainable`, hubo que hacerlo a mano en `ARGAge0`).

## Corrales
`Sheep` sacado vía `CommandRemove` (no `Enable=0` global), `Cow` agregado vía `AddTrain`.
Límite de vacas: **50** (v9.0, `BuildLimit` en `ARGAge0`).

## Cuartel
`dePavisier`/`Pikeman`/`Halberdier` deshabilitados (liberan columnas 0/1/2 nativas de Italia).
Roster (v9.0, 5 unidades):
- **Milicia Criolla** (ex "Criollo") = `Musketeer` real (col 1), reposicionado vía
  `CommandRemove`+`CommandAdd`. Mejoras propias `ARGVeteranMiliciaCriolla`/
  `ARGGuardMiliciaCriolla`/`ARGImperialMiliciaCriolla` — CLONES de las reales
  `VeteranMusketeers`/`RGRedcoats`/`ImperialMusketeers` (no se pueden activar directo, son
  compartidas con cualquier civ que también use Musketeer real). La clon de Guardia preserva
  el `TechStatus active GuardMusketeers` interno de `RGRedcoats` para que el `animfile` siga
  mostrando el modelo/sombrero real de "casaca roja" (Redcoat) — el `SetName` propio pisa el
  nombre después sin afectar el cambio visual.
- **Patricio** (ex "Granadero") = `deSoldado` real de México (col 2). Mejoras 100% nuevas
  `ARGVeteranPatricio`/`ARGGuardPatricio`/`ARGImperialPatricio` (deSoldado no tenía línea de
  mejoras real que clonar). **Pendiente**: el sombrero de Redcoat es un modelo de CUERPO
  distinto al de Patricio (`soldado.xml` vs `musketeer\redcoats_age4`) — igualar el sombrero
  exacto necesitaría un `animfile` propio (mismo patrón EXPERIMENTAL que `roudorobant.xml`),
  no implementado todavía.
- **Gaucho** = `deStateMilitia` real (col 0). Puede construir Corrales + acceso directo a
  "construir" una vaca (necesitó `ActionEnable Build` explícito además del `CommandAdd`).
- **Gaucho Jujeño** (nuevo, col 4): `ARGSpyGaucho`, clon completo del Espía real (`xpSpy`,
  mismas stats/tactics/bonos x20-x40 vs Mercenario/Héroe) con el modelo/ícono real del
  Salteador/Vigilante mexicano (`deEmboscador` — el mismo proto real, "Salteador" de base,
  sube a "Vigilante"/"Vigilante Imperial" con las techs reales `DEVigilantes`/
  `DEImperialVigilantes`). Multiplicadores agregados: x7 vs `AbstractHeavyCavalry`, x5 vs
  `AbstractRangedShockInfantry`. Puede construir Cuarteles (`CommandAdd` de `Barracks` sobre
  sí mismo) y tiene la misma habilidad de Corral/vaca que el resto de los Gauchos.
- **Gaucho Pampeano** (nuevo, col 6): reutiliza DIRECTO el proto real `deEmboscador`
  (guerrilla mexicana real, `tactics=guerrilla.tactics` — el mismo asset que le da modelo a
  Gaucho Jujeño, pero acá como unidad de cuerpo entero) vía `CommandAdd`, renombrado.

## Establo
`Lancer` real deshabilitado, reemplazado por `ARGLancer` propio (mismos stats, animfile/icon
de `deRevolutionaryScout`). Húsar → **"Blandengue"**, Dragón → **"Infernal"** (v9.0, `SetName`
sobre `Hussar`/`Dragoon` reales, nunca tocados antes). Columna 3: **Gaucho Entrerriano** (ex
"Gaucho a Caballo", `deREVGaucho` real) — rebalanceado a 1 población/120 madera (venía pensado
para envío masivo, 7 población/120 oro), con la misma habilidad de recolección de ganado que
el Gaucho de infantería. Bono de daño (v9.0): x3 vs `AbstractHeavyCavalry` → x3 vs
`AbstractHeavyInfantry`. **Granadero a Caballo** (`deREVGranadero`) ya NO vive acá — se mudó a
la Fundición (v9.0, ver abajo).

## Fundición (ArtilleryDepot)
(v9.0) El Granadero real (heredado por defecto de Italia vía `DEGrenadierEnable`, nunca antes
deshabilitado explícitamente) se deshabilita junto con sus 5 techs de mejora. En su lugar,
**Granadero a Caballo** (`deREVGranadero`, real, sin cambios de stats) ocupa la columna 1 vía
`CommandAdd` en `ARGAge0`.

## Bono de civ
Colono gratis por cada tech investigada — mecánica real de Italia (`SetOnTechResearchedTech`
+ `DEShipItalianVillager`), reapuntada en `ARGAge0` a una réplica propia (`ARGShipCowOnTech`)
que envía una vaca en vez de un colono. **Confirmado (v9.0): esto ya funcionaba desde v5.0,
no había ningún bug que corregir** — el usuario lo mencionó como posible pendiente pero era
solo un pedido de confirmación.

## Sonido
Bug de civlogic-sin-rama en `Settler`/`Explorer`/`Dragoon`/`Hussar`/`Priest`/`xpSpy` (todos
heredados de Italia sin tocar, quedaban mudos igual). Caso especial: `deStateMilitia`
(Gaucho) tiene su `_snds.xml` real 100% PLANO (sin civlogic) — agregar civlogic nuevo vía
`.mods.xml` NO funciona en juego; hubo que sobreescribir directo el soundset plano (afecta a
cualquier civ que comparta ese proto). `ARGSpyGaucho` (clon nuevo de `xpSpy`) tiene su propio
`sound/argspygaucho_snds.xml` PLANO (v9.0, reusa los soundsets `MMSpanishLightCavalry*` ya
registrados para el Espía de esta civ). `deEmboscador` (Gaucho Pampeano) es universal — sin
`<civlogic>` en su `_snds.xml` real — así que no necesitó nada.

## Deuda técnica / pendiente
- `chatset` de la IA (`Bolivar`) sin verificar contra un valor real del juego.
- Confirmar visualmente la 5ª columna del Establo (territorio nunca usado antes en este mod).
- Sombrero de Redcoat en Patricio (deSoldado) — necesitaría `animfile` propio, no
  implementado.
- "Lancero Veterano" (pedido quitar) — no existe ninguna mejora con ese nombre para
  `ARGLancer` hoy, no hubo nada que remover.
- Confirmar en juego el roster completo del Cuartel (5 unidades, columnas 0/1/2/4/6) sin
  duplicados ni errores de audio/modelo.
