# Holanda Italiana (`ITDItaloDutch`)

**Clon de**: Holandeses (identidad primaria: ciudad natal, edades, colono, Iglesia, Banco,
caballería) **fusionado con** Italia (sistemas injertados: colono gratis por tech, Bersagliere
propio, mazo fusionado). **IDs**: 88887xxx. **Agregada**: v6.7, ampliada v6.9.

## Identidad
Única civ del mod que fusiona DOS civs reales en vez de clonar una sola.

## Mecánicas de Italia injertadas
- **Colono gratis por tech investigada**: mecánica real (`DEShipItalianVillager`, engancha vía
  `SetOnTechResearchedTech` en `DEAge0Italians`) copiada al `ITDAge0` sin tocar la tech.
- **Bersagliere propio** (`ITDBersagliere`, 88887206): escalado de stats por EDAD, sin mejora
  investigable — ×0.60 en `ITDAge0`, ×1.3333 en `ITDFortressize` (→0.80), ×1.25 en
  `ITDIndustrializar` (→1.00). Techs `Shadow` que se activan solas al subir de edad, el
  jugador nunca "elige" mejorarlo. `allowedage=1` (entrenable 2 edades antes que el real).
  Cartas propias `ITDShipBersagliere1`/`ITDShipBersagliereRepeat` (las reales apuntan al
  Bersagliere real, que esta civ no habilita).
- **"Espingarda" (culebrina italiana)**: `ITDSpingardes`/`ITDImperialSpingardes`, clones de
  `DESpingardes`/`DEImperialSpingardes` reales SIN el `reqtech="DEAge0Italians"` de su
  `SetName` (esta civ no activa esa tech). `GrapeShot`/`ImperialCulverin` genéricas quedan
  `unobtainable`.

## Colonos y exploradores DUALES (v6.9)
`ITDSettlerDutch`/`ITDSettlerItalian` (88887213/214) y `ITDExplorerDutch`/`ITDExplorerItalian`
(88887215/216) — clones COMPLETOS del `Settler`/`Explorer` real (heredan su `<train>` embebido
de ~130 entradas gratis) porque `buildlimit` (35 cada uno) es propiedad del PROTO, no se puede
variar por mitad de población dentro de un mismo proto.

## TownCenter: Arquitecto + Emisario simultáneos
`Envoy`/`deArchitect` comparten columna 2 en el `TownCenter` real (cada civ real usa solo
uno). `deArchitect` reubicado a columna 4 vía `CommandRemove`+`CommandAdd`, `Envoy` intacto.

## Mazo fusionado
Unión deduplicada por `<name>` (NO concatenación — media docena de decenas de cartas
genéricas se repiten textualmente entre civs europeas). De 255 cartas de Italia, 119 eran
exclusivas. Excluidas: 10 cartas `DEBasilicaShip*` (Basílica, esta civ usa Iglesia normal) y
las cartas del Bersagliere real.

## Colisiones de columna resueltas por omisión
Dock (`Fluyt` vs `deGalleass`, col 2) y build-menu del Settler (`House` vs `HouseMed`, col 0):
no se agregó nada de Italia ahí porque el usuario no lo pidió explícitamente para esa
categoría — evita la colisión sin esfuerzo.

## Sonido
Colono/Explorador con voz holandesa (`MMDutch*`, nuevos). Bersagliere con voz italiana real
(`DEItalianGrenadierSelect/Acknowledge/Attack`, universal, sin registro `MM` necesario).
Culebrina con voz italiana real también (tiene rama `DEItalians`, necesitó rama
`ITDItaloDutch` nueva). **Bug pre-existente encontrado de paso: HOT/HGE nunca habían recibido
rama de Colono/Explorador** — corregido aquí mismo.

## Deuda técnica / pendiente
- Confirmar visualmente ~352 cartas sin errores de carga, Cuartel sin duplicados, Bersagliere
  débil en Edad II / fuerte en Edad IV en partida real.
