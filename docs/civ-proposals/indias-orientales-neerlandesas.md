# Indias Orientales Neerlandesas — ✅ IMPLEMENTADA (v15.0)

**Ver el estado real en [`docs/civs/14-indias-orientales-neerlandesas.md`](../civs/14-indias-orientales-neerlandesas.md).**
Todo lo de más abajo es el registro histórico de la propuesta original.

**Base**: Portugueses, con revolución indonesa injertada (mismo espíritu que Holanda
Italiana, que fusiona dos identidades — ver `docs/civs/07-holanda-italiana.md`).

## 🔎 Hallazgo (investigación 2026-09-09)
Los 4 protos base citados por el usuario están **confirmados reales, ortografía exacta**
(verificado directo en `protoy.xml`): `ypRepentantSmuggler` (id 1425), `deSaloonOutlawCossack`
(id 2406, nota: el pedido lo escribió "adeSaloonOutlawCossack", con una "a" de más —
confirmado typo), `ypWokouWaywardRonin` (id 1035), `ypNatChakram` (id 947). Sin necesidad de
corrección de nombres antes de implementar.

`DERevIndonesia` existe en `civs.xml` como civ-flag de revolución real (no investigada a
fondo en esta pasada — pendiente confirmar su mecánica/roster antes de asumir que la
"revolución indonesa" mencionada por el usuario es necesariamente esta).

## Cuartel
- Lancero Javanés.
- `ypRepentantSmuggler` renombrado **"Jawa"**: costo entre alimento y monedas, 2 de
  población, quitarle el tipo "forajido" (`Outlaw`/`LogicalTypePickableMerc*`, mismo patrón
  ya usado en este mod para `HUNHajduk`/`HUNCrabat`/`HUNPandur` al despojarlos del mecanismo
  mercenario).
- Irregular.

## Establo
- `deSaloonOutlawCossack` (⚠️ escrito "adeSaloonOutlawCossack" en el pedido, probable typo)
  renombrado **"Berkuda"**: costo entre alimento y monedas, 2 de población, quitarle el tipo
  "forajido".
- `ypWokouWaywardRonin` renombrado **"Pemanah Kuda"**: costo entre alimento y monedas, 2 de
  población, quitarle el tipo "forajido".

## Artillería
- `ypNatChakram` renombrado **"Prajurit Kraton"**.
- Cetbang.

## Pendiente de definir antes de implementar
- Rango de IDs propio.
- ~~Confirmar los 4 protos base reales~~ → **resuelto, ver hallazgo arriba, los 4 son
  reales**.
- Definir el costo exacto (montos de alimento/monedas) para los 3 renombrados de tipo
  "quitarle forajido".
- Investigar el contenido real de `DERevIndonesia` antes de asumir qué trae la "revolución
  indonesa" — no se confirmó en esta pasada.
