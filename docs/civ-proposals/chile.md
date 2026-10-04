# Chile — ✅ IMPLEMENTADA (v13.0)

**Ver el estado real en [`docs/civs/12-chile.md`](../civs/12-chile.md).** Todo lo de más
abajo es el registro histórico de la propuesta original.

## 🔎 Hallazgo clave (investigación 2026-09-09)
**Ya existe una revolución real `DERevolutionChile`** (dbid 6425, displaynameid 80843 =
"Chile", `revolutionciv=DERevChile` con bandera real `objects\flags\chilean`,
`Flag_Chilean.png`, botón `oHigginsFlagBtn` — referencia a Bernardo O'Higgins). Su mecánica
real:
- Habilita `xpColonialMilitia`.
- **"Húsar de la muerte" CONFIRMADO EXACTO**: la tech renombra `Hussar` vía `SetName` a la
  string real 80935 = **"Húsar de la muerte"**, con `+200% Damage` y activa
  `VeteranHussars`/`GuardHussars`. Envía 8 Húsares gratis al revolucionar. Ícono propio
  `deIconREVChileanHussar`.
- Economía: `BuildLimit=10` en `Plantation`, bonus de oro en `Plantation` (+45%/+50%),
  `BuildLimit=70` en `Settler`, consulado alemán grande (`ypBigConsulateGermans`).
- **No hay ninguna civ real marcada como base "de origen" única para esta revolución en la
  investigación** — antes de implementar, confirmar contra qué `Age0<Civ>` real se activa
  `DERevolutionChile` como `obtainable` (candidatos vistos en los datos: aparece listada junto
  a `DERevolutionColombia` en el mismo bloque, sugiriendo una civ ibérica — Española o
  Portuguesa).

Recomendación: como con Argentina/Rumania, conviene mirar primero si "clonar la civ real que
puede revolucionar a Chile + reusar el Húsar de la Muerte real" cubre gran parte del pedido,
en vez de inventar todo desde cero.

## Inicio
(sin detalle en el pedido original — pendiente).

## Cuartel
- Infantes: Soldado Mexicano (`deSoldado`, proto real ya usado como "Granadero" en Argentina
  — confirmar si Chile lo reutiliza igual o con otro nombre).
- Fusileros: Guerrilleros.

## Caballería
- Húsares de la Muerte (⚠️ nombre "de sabor" — confirmar proto real, posible mercenario/
  unidad temática de la muerte).
- Dragones.
- Cazador a Caballo.

## Artillería
- Granaderos.

## Detalle de civ
- Puede entrenar Dragones desde Edad II, pero un 20% más débiles (mismo patrón de escalado
  por edad ya usado en este mod para el Bersagliere de Holanda Italiana y el Jinete Arquero
  de Valaquia de Rumania — ver `docs/civs/07-holanda-italiana.md`/`08-rumania.md`).

## Pendiente de definir antes de implementar
- Civ base real a clonar (revisar contra qué `Age0<Civ>` real se activa `DERevolutionChile`
  como `obtainable` — no confirmado en esta pasada).
- Rango de IDs propio.
- Detalle de "Inicio".
- ~~Confirmar nombre real de "Húsares de la Muerte"~~ → **resuelto: "Húsar de la muerte" es
  exacto**, viene de `DERevolutionChile`.
- El roster pedido (Soldado Mexicano, Guerrilleros, Dragones, Cazador a Caballo, Granaderos)
  NO viene de `DERevolutionChile` (que solo toca Húsar/Plantación/Milicia) — son adiciones
  propias del usuario, sin precedente real que las respalde. Implementar como clones/reusos
  normales, no como "ya existente".
