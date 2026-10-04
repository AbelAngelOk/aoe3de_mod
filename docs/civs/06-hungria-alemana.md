# Hungría Alemana (`HGEHungary`)

**Clon de**: Alemanes (`Germans`). **IDs**: 88886xxx. **Agregada**: v6.6. Reusa la bandera real
de Hungría con el buttonset/vistas de ciudad natal de Alemanes.

## Identidad
Segunda variante "germanizada" de Hungría — conserva más unidades nativas alemanas
(Ballestero/Dopplesoldner) que la Hungría base.

## Unidad propia (solo esta civ)
- `HUNPandur` (88886205): clon de `deMercPandour` sin ser mercenario de Fortaleza (quitados
  `Mercenary`/`FortressMercenary`/`LogicalTypePickableMerc*`), Edad 1 en vez de Fortaleza.

## Trampa de colisión de columna
- Establo col 0/1: Alemanes deja `Uhlan`/`WarWagon` activos ahí (mismo fix que ya usa Hungría
  base).
- Cuartel col 1: `HUNHajduk` colisiona con `Pikeman` (que esta civ SÍ quería conservar, a
  diferencia de la Hungría base que deshabilita todo el roster alemán) — hubo que
  deshabilitarlo igual con sus 3 mejoras, SOLO por la colisión, no porque el usuario lo pidiera.
  `Dragoon` (col 2 del Establo) se dejó intacto (no colisiona).

## Cartas nuevas
`HUNShipPandurs1-4` (7/9/8/12, cantidades tomadas de `HCShipSkirmishers1-4German` reales que en
realidad son cartas mixtas Skirmisher+Uhlan, simplificadas a Pandur puro).

## Sonido
`hunpandur_snds.xml` plano, reusa `CroatianOutlawSelect`/etc. sin civlogic. Mismo bug de
Colono/Explorador que HOT (v6.9): faltaba la rama completa — se agregó registrando ~35
soundsets `MMGerman*` nuevos desde cero (patrón completo: extraer bloque real, copiar `.wav`
físico a `sound/mm/`, registrar).

## Deuda técnica / pendiente
- `TechStatus obtainable` de `HUNShipHajduks1-4`/`HUNShipCrabats1-5` en `HGEAge0` es
  probablemente redundante (Hungría base nunca lo hace y funciona) — no confirmado.
- Confirmar en juego el Establo/Cuartel sin duplicados.
