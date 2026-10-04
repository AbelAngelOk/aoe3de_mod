# Finlandia (`DEFinnish`)

**Clon de**: Suecia (`DESwedish`). **IDs**: 88882xxx. **Agregada**: v3.0. Techs `FIN*` delegan
en los reales de Suecia. Reusa la bandera real de `DERevFinland`. Civ **normal** (las
revoluciones se probaron en juego y se abandonaron en v3.8, ver
[[aoe3-revolution-mechanism]]).

## Identidad
Infantería de bosque + economía forestal + artillería ligera.

## Blocao (único edificio militar — Cuartel eliminado en v7.0)
El Cuartel se deshabilitó y todo su roster se mudó al Blockhouse compartido (columnas 0/3/4,
sin colisión porque Finlandia nunca habilita los protos reales de Rusia/Rumania que también
usan esas columnas):
- **Jaeger de Carelia** (`FINKarelianJaeger`, col 0): proto propio. Costo 100 madera, Edad I,
  panel de 13 edificios y recolección de SOLO madera definidos directo en el proto. Puede
  construir y talar como un colono (paridad con la revolución real: `Build`/`Gather`/
  `Hunting`/`ChopAttack`/`CrateGather`/`HandAttackCrate`/`WorkRate` sobre crates). Modelo
  propio EXPERIMENTAL (`art/units/infantry_ranged/karelianjaeger/karelianjaeger.xml`, v7.0):
  el animfile real (`Skirmisher`) solo muestra el cuerpo correcto (Carolean Edad IV + textura
  `jaeger` dedicada) si la tech `DERevolutionFinland` está activa (trae `InitiateRevolution`
  — bloqueo de edad, inaceptable para civ normal), así que se clonó el animfile con esa rama
  sin condición. Sin confirmar en juego si `art/` es overrideable.
  3 mejoras acumulativas (Tier2/3/4, Edad II/III/IV, +20% c/u, sin Imperial).
- **Jaeger de Savonia** (`MercJaeger` real, col 1): restaurado como entrenable. Costo 80
  madera + 80 oro vía `Cost relativity="Absolute"` (delta, no assign) en `FINAge0`. Modelo
  dedicado confirmado: activar la tech real `DEChurchSavolaxJaegers` directo (`TechStatus
  active`) en vez de replicar sus efectos a mano — el `<logic type="Tech">` del animfile
  necesita el nombre EXACTO de la tech, no solo los mismos números (fix v7.0). Efecto
  secundario aceptado: esa tech también da 6 Jaegers gratis. 1 mejora (`FINImperialSavolaxJaeger`,
  +50%, Edad V).
- **Jaeger de Contraataque** (`deConsulateCounterJaeger`, col 2): visible pero bloqueado hasta
  Edad IV. Línea Guardia/Imperial propia.

## Establo
`deCounterDragoon` (Dragón de Contraataque) desbloqueado en Edad IV por defecto.

## Iglesia
Streltsy/Alabarderos/Rekluts (envían + habilitan su unidad en el Blocao) + `FINChurchCannons`
(2 Cañones de Cuero, no rusos). "Tratado de Hamina" desbloquea esas 4 cartas + 3 mejoras
Veterano/Guardia/Imperial del Blocao (solo stats, sin `UpdateVisual`, para no filtrar el
cambio visual a Rusia real que también usa Strelet/Rekrut) + "25 Mosqueteros del Norte".

## Fundición
Sin Granadero base ni Cañones de Infantería (heredados de Suecia) — ambos deshabilitados.

## Cartas de metrópoli
18 cartas `FINRev*` (réplicas propias que activan la tech real de revolución vía `TechStatus
active`, ubicadas en la Academia) de las 23 originales — 5 quitadas por duplicadas o por no
encajar en el diseño de civ normal.

## Deuda técnica / pendiente
- Modelo del Jaeger de Carelia: EXPERIMENTAL, depende de que `art/` sea overrideable (nunca
  confirmado en juego, a diferencia de `sound/`).
- Confirmar visualmente Blocao/Iglesia/Fundición sin duplicados y que Savonia realmente
  cambia de uniforme al investigar la mejora del Cuartel.
