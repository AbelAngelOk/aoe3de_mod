# Estados Berberiscos — ✅ IMPLEMENTADA (v11.0)

**Ver el estado real en [`docs/civs/10-estados-berberiscos.md`](../civs/10-estados-berberiscos.md).**
Todo lo de más abajo es el registro histórico de la propuesta original.

**Base**: Otomanos (mismo patrón que Egipto — ver `docs/civs/04-egipto.md`).

## 🔎 Hallazgo clave (investigación 2026-09-09) — muy bien resuelto
`DERevolutionBarbaryStates` es real (dbid 6438, displaynameid 80806 = **"Estados
berberiscos"**, `revolutionciv=DERevBarbaryStates`, bandera real `objects\flags\spc_barbary`,
`Flag_barbary.png`). Mecánica real:
- `InitiateRevolution` → los colonos se convierten en **`deREVBarbaryWarrior`** (coincide con
  "Guerreros Berberiscos" del pedido).
- Habilita `Privateer` (Corsario) y `deStartingUnitPrivateer`, entrenable desde ahí según la
  civ base (ver shadows abajo).
- Envía 10 **`deAllegianceBarbaryMarksman`** gratis (coincide con "Tiradores Corsarios").
- Rollover real: "Envía 10 tiradores corsarios y permite reclutar naves corsarias del muelle.
  Los colonos se convierten en guerreros berberiscos."

**Las 4 variantes "shadow" (una por civ base real que puede revolucionar) tienen su roster
COMPLETO confirmado — esto resuelve casi todo el diseño de la civ**, cada una añade su propio
roster de infantería/caballería/artillería entrenable desde el Corsario:
- **`DERevolutionBarbaryStatesOttomanShadow`** (prereq `Age0Ottoman`) — **la que corresponde
  a "base otomana" pedida por el usuario**: añade `Janissary`, `Hussar`, `CavalryArcher`,
  `Grenadier`, `AbusGun`.
- `DERevolutionBarbaryStatesPortugueseShadow` (prereq `Age0Portuguese`): `Crossbowman`,
  `Pikeman`, `Musketeer`, `Cacadore`, `Halberdier`, `Hussar`, `Dragoon`.
- `DERevolutionBarbaryStatesItalianShadow` (prereq `DEAge0Italians`): `Musketeer`,
  `dePavisier`, `Pikeman`, `deBersagliere`, `Hussar`, `Dragoon`, `Grenadier`.
- `DERevolutionBarbaryStatesMalteseShadow` (prereq `DEAge0Maltese`): `Crossbowman`,
  `Pikeman`, `deHospitaller`, `deMalteseMusketeer` — **relevante también para la propuesta
  "Caballeros Hospitalarios"**, y además reemplaza `deHospital`→`Barracks`.

## Cuartel
- Pirata.
- Guerreros Berberiscos → **`deREVBarbaryWarrior`** (confirmado real).
- Tiradores Corsarios → **`deAllegianceBarbaryMarksman`** (confirmado real).

## Establo
- Jinete del Magreb.
- Jinete Makhzen.
- (⚠️ ninguno de los dos aparece en el roster real de la shadow Otomana, que trae
  `Hussar`/`CavalryArcher` en su lugar — decidir si se reemplazan por esos, o si Jinete del
  Magreb/Makhzen son protos reales adicionales sin identificar todavía).

## Inicio
- Sin Explorador. En su lugar: **Capitán Corsario** (`DEHCREVCorsairCaptain` — confirmado
  que existe como nombre de tech real, dbid en la línea 80781 de `techtreey.xml`, contenido
  no investigado en detalle en esta pasada).

## Pendiente de definir antes de implementar
- ~~Revisar si hay una revolución/mecánica real~~ → **hecho, resuelto casi por completo**.
  Recomendación: clonar Otomanos + `DERevolutionBarbaryStatesOttomanShadow` como base directa
  del roster de Cuartel/Artillería.
- Rango de IDs propio.
- Confirmar si "Jinete del Magreb"/"Jinete Makhzen" son protos reales distintos de
  `Hussar`/`CavalryArcher`, o si el usuario quiere renombrar estos últimos.
- Investigar contenido exacto de `DEHCREVCorsairCaptain` (para el Explorador propio).
