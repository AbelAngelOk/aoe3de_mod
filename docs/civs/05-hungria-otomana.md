# Hungría Otomana (`HOTHungary`)

**Clon de**: Otomanos (`Ottomans`). **IDs**: 88885xxx. **Agregada**: v6.6. Reusa la bandera
real de Hungría (`objects\flags\hungarian`) con el buttonset/vistas de ciudad natal de
Otomanos.

## Identidad
Variante "otomanizada" de Hungría — mismo roster núcleo húngaro (Hajduk/Crabat/Magyar Hussar)
sobre una base otomana en vez de alemana.

## Unidades compartidas con Hungría Alemana (viven una sola vez en `protomods.xml`)
- `HUNGrenzer` (88885206): clon de `deNMPandour` sin `AbstractBasilicaUnit` ni costo en XP —
  cuesta recursos normales, Edad I.

## Trampa de colisión de columna (primera vez documentada con una civ base DISTINTA)
Cada `<train>` de un building compartido fija una columna por NOMBRE — es la MISMA para toda
civ que entrene ese proto. El truco para que varias civs coexistan es que cada una deshabilita
lo que su civ real de base deja activo en esa columna:
- Establo: `HUNMagyarHussar`/`HUNCrabat` van a col 0/1 (igual que Hungría base), pero Otomanos
  deja `deDeli` activo en col 0 → hubo que `Enable 0` + `unobtainable VeteranDelis`
  explícitamente (no pedido por el usuario, requisito mecánico). `CavalryArcher` (col 2)
  deshabilitado con sus 3 mejoras (pedido explícito).

## Cartas nuevas
`HUNShipGrenadier1/2/Repeat` (plantilla real `DEHCShipHumbaracis1/2/Repeat`).

## Sonido
`hungrenzer_snds.xml` plano, reusa soundsets croatas reales (`CroatianMilitarySelect`/etc.)
sin civlogic. **Bug encontrado de paso (v6.9): nunca había recibido rama de Colono/Explorador**
— agregada, reusa soundsets `MM*` ya registrados por Egipto (misma base Otomanos).

## Deuda técnica / pendiente
- Confirmar que aparece en el selector y que el Cuartel/Establo no muestran botones
  duplicados.
- Voz de Grenzer sin confirmar en juego.
