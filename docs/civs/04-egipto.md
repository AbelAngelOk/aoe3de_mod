# Egipto (`EGYEgypt`)

**Clon de**: Otomanos (`Ottomans`, **sin** prefijo `DE` — civ base del juego, no DLC). **IDs**:
88884xxx. **Agregada**: v6.0, corregida v6.1-6.4. Techs `EGY*` delegan en `Age0Ottoman`/
`ColonializeOttoman`/etc. Bandera real `DERevEgypt` (assets ya en el juego) con buttonset de
Otomanos (no tiene uno propio).

## Identidad
Camellería + Mamelucos + Establo con modelo de Campamento de Guerra.

## Establo — primer cambio de MODELO de building compartido en este mod
`Stable` es un proto único compartido por TODAS las civs; tocarlo reskinearía a todo el mundo.
Se clonó el proto entero (`EGYStable`, animfile real de `deWarCamp`) y se reapuntó el botón de
construcción del Colono (`page="6" column="12"`, vive en el proto `Settler`, no en el
`TownCenter`) vía `CommandRemove`+`CommandAdd`. `EGYStable` necesitó su propio
`egystable_snds.xml` plano (un clon nuevo no hereda sonido solo por compartir gran parte de su
definición).
Roster: `deNatCamelRider` (jinete a camello, no `deMercGatlingCamel`; se le asignó
`PopulationCount`/`BuildLimit relativity="Assign"` porque nativamente es `populationcount=0`/
`buildlimit=9`, pensado para uso nativo) y `MercMameluke`.

## Trampas de nombres reales
- No existe `Sipahi` — es **`Spahi`**. Envío exclusivo por HC, nunca entrenable.
- Otomanos NO usa el `Grenadier` genérico — tiene `deHumbaraci` propio (col 1 de
  ArtilleryDepot).
- `deNizam` (buildlimit=20 nativo) solo llega por cartas reales; producirlo en un edificio
  necesita `CommandAdd` propio.
- `DEHCREVNizamsEgypt` no envía Nizam pese al nombre — envía `xpColonialMilitia`.

## Cartas
Familias reales encadenadas por `<prereqtech>` (`DEHCShipDelis1-5`, `HCShipSpahis1-4-Team`):
al reemplazar solo una parte de la cadena por Mamelucos, hubo que cortarla y crear una cadena
nueva independiente entre las réplicas.

## Sonido
`deNatCamelRider`/`MercMameluke`/`deMercGatlingCamel`/`deNizam` universales (sin civlogic,
nada que hacer). `Settler`/`Explorer`/`CavalryArcher`/`Imam` sí tienen civlogic con rama
`Ottomans` real — mismo fix "MM" (soundsets `MMOttomanSettlerMale*`/`MMOttomanExplorer*`/
`MMSahin*`/`MMOttomanCavalryArcher*`/`MMOttomanImam*`).

## Deuda técnica / pendiente
- Confirmar que `EGYStable` renderiza el modelo de War Camp con el ícono correcto de Establo.
- `deNatCamelRider` necesitó `SetName` explícito (habilitar un proto no lo renombra solo).
