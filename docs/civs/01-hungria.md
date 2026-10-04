# Hungría (`HUNHungarians`)

**Clon de**: Alemanes (`Germans`). **IDs**: 88881xxx. **Agregada**: v1.0 (primera civ del mod).
Techs de edad `HUNAge0…HUNPostImperial` delegan por `TechStatus active` en los reales de
Alemania. Home city propia (`homecityhungarymin.xml`, copia de `homecitygerman.xml`).

## Identidad
Caballería magiar + infantería irregular (Hajduk) + granadera propia. Sin Granadero base.

## Cuartel
Roster propio, columnas fijas: **Hajduk** (col 1) reemplaza al Alabardero/infantería alemana.
- `HUNHajduk` (88881202): clon de `deSaloonHajduk` (mercenario croata real) sin mecanismo de
  mercenario, costo en recursos normales. Sin ascensos de rango. Bono x3 cuerpo a cuerpo vs
  infantería (se le quitó el x2 vs caballería que tenía en v1.x).
- `HUNHonved` (infantería de línea, fusil de aguja): modelo casaca roja propio, ícono propio.
- Mejoras propias de Hajduk/Honvéd en el Cuartel (Guardia IV / Imperial V, sin nivel III).

## Establo
- `HUNMagyarHussar` (88881204): clon de `deLegionMagyarHussar`, 3 población.
- `HUNCrabat` (88881205): clon de `deSaloonCrabat` sin mercenario, 2 población (antes 4), sin
  ascensos. x3 cuerpo a cuerpo vs infantería, x3 a distancia vs caballería, x2 vs artillería.
- Caballería alemana nativa (`Uhlan`/`WarWagon`) deshabilitada + sus mejoras `unobtainable`.
- 4 mejoras propias (Guardia IV +20%, Imperial V +50%, nada en III).

## Artillery Foundry
- Granadero base y sus mejoras (`VeteranGrenadiers`/`GuardGrenadiers`/`ImperialGrenadiers`/
  `RGPavlovGrenadiers`/`ImperialPavlovs`) deshabilitados.
- `HUNGrenadier` (88881208): clon de `deNatHungarianGrenadier` SIN los tipos de consulado
  (`AbstractConsulateUnit`/`AbstractConsulateUnitColonial`) — no recibe mejoras automáticas
  del consulado. 3 mejoras propias investigables ahí mismo (Veterano III / Guardia IV /
  Imperial V). **Compartido con HOT/HGE** (cada una lo habilita en su propio Age0).

## Cartas de metrópoli
Mercenarios propios: Banda de Pandúros (6 `deMercPandour`), Dieta de Presburgo (7 pandúros
∞ equipo), Apoyo de Jinetes Negros (5 `MercBlackRider` ∞ equipo), Regimiento de Trenck (4
pandúros equipo), Arcabuceros a Caballo (11 `deMercHarquebusier`). 16 cartas alemanas de
mercenarios/aliados quitadas del mazo.

## Sonido
Bug de raíz resuelto en v2.6: todo proto con nombre nuevo (`HUN*`) necesita su propio
`sound/<proto>_snds.xml` — si no, queda mudo aunque anime bien (comparte animfile con la
unidad real). 7 archivos creados (Hajduk, Honvéd, Húsar Magiar, Crabat, Inf. Montada/
Desmontada, Carretón). Ver [[aoe3-unit-sounds-snds]].

## Deuda técnica / pendiente
- Confirmar en juego que HUNGuardCrabat/HUNImperialCrabat (compartidas con HOT/HGE si aplica)
  no arrastran ningún efecto cruzado.
- Es la civ MÁS antigua del mod — varias de sus decisiones de v1.x-2.x (ej. nomenclatura sin
  prefijo consistente en cartas viejas) preceden convenciones adoptadas después.
