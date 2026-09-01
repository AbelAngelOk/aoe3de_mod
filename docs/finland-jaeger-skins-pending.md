# Skins de los jaegers finlandeses (Carelia / Savonia) — resuelto (mod-minimal 3.4)

## Qué se descubrió

El flag `UpgradeTech` + `UpdateVisual` **no cambia el skin de un proto clonado** — solo del
proto BASE. Confirmado comparando `GuardSkirmishers` (vanilla) con nuestras mejoras: ambas usan
el mismo patrón exacto (`Hitpoints`/`SetName`/`UpdateVisual`/`Damage`), sin ningún efecto
adicional de "cambio de modelo" — el motor resuelve el nivel visual internamente por proto-id,
dentro del animfile compilado (`units\infantry_ranged\skirmisher\skirmisher.xml`, fuera del
alcance de un data-mod).

## Solución aplicada — Carelia

Se implementó el "Plan B": el Jaeger de Carelia **ahora ES el `Skirmisher` real** (se retiró el
proto propio `FINKarelianJaeger`). El bloqueo que quedaba pendiente — el panel de construcción
en un proto COMPARTIDO sin afectar a Francia/Holanda/Alemania/España — se resolvió así:

- Todos los efectos (edad de aparición vía `AllowedAge -2.00`, costo, nombre, recolección,
  `ActionEnable` Build/Gather/etc.) se aplican **por-jugador** dentro de `FINAge0`, igual que
  `DEChurchSavolaxJaegers` hace con `MercJaeger` en el juego base. Los efectos de tech solo
  aplican al jugador que investiga esa tech — Finlandia no interfiere con otras civs que
  también habilitan Skirmisher por su cuenta.
- El panel de construcción (13 edificios curados: economía + militares clave) se otorga vía
  `subtype="AddTrain"` por-jugador — NO editando el `<train>` estático del proto compartido
  `Skirmisher` en `protomods.xml` (eso sí habría filtrado el botón a cualquier civ con
  Skirmisher habilitado).
- Ver `mod-minimal/data/techtreemods.xml`, tech `FINAge0` (Cambio 31) para la implementación
  completa.

Pendiente de confirmar en juego: que investigar las mejoras del Cuartel efectivamente cambie el
uniforme del Carelio (gris con chacó en Guardia), ya que ahora sí es el proto base real.

## Solución aplicada — Savonia

Savonia (`MercJaeger`) ya usaba el proto real (no un clon) desde antes. Su mejora del Cuartel
sube estadísticas correctamente, pero **el skin no cambia**: los mercenarios no tienen arte de
veterancía en el juego base (ninguna civ que contrata `MercJaeger` ve un cambio de uniforme al
subirlo de nivel). Esto es una limitación del juego base, no del mod — no hay "Plan C" posible
sin arte 3D nuevo, que está fuera del alcance de un data-mod.
