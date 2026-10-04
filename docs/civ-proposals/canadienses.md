# Canadienses (propuesta, sin implementar)

## 🔎 Hallazgo clave (investigación 2026-09-09) — ⚠️ discrepancia importante
Existen **dos** revoluciones reales `DERevolutionCanadaFrench` (dbid 6431) y
`DERevolutionCanadaBritish` (dbid 6439), mismo `displaynameid 80814` = **"Canadá"**, misma
`revolutionciv=DERevCanada` (bandera real `objects\flags\canadian`, `Flag_Canadians.png` —
sin `homecityflagbuttonset` propio, a diferencia de Brasil/Colombia/Chile, que sí lo tienen).

**Pero su mecánica real NO coincide con lo que describe el pedido.** Lo que hacen de verdad:
- `InitiateRevolution proto="none"` — **los colonos NO se convierten en una unidad militar**;
  en cambio ganan ataque a distancia directo (`BlunderbussAttack`/`RifleAttack`/
  `SpearAttack`, daño 17, autoataque habilitado) — "colonos armados", no transformación.
- `PetGrizzly`: oso de mascota entrenable (`BuildLimit=50`) con bono contra aldeanos rivales.
- `Coureur`→ renombrado (string 80854) y `Settler`→ renombrado (string 80855). En la variante
  **British**, además `SettlerNative`/`ypSettlerAsian`/`ypSettlerIndian`/`ypSettlerJapanese`
  reciben el mismo renombre + ícono `deIconREVMetisPathfinder` — es decir, ahí sí aparece un
  "colono se convierte visualmente en explorador/pathfinder Métis", pero como SKIN del colono,
  no como Explorador de civ. En la variante French esto no pasa.
- `MercHighlander` renombrado también (string 42455) — dato curioso, sugiere que Highlander
  SÍ tiene un lugar real en el diseño de Canadá (relevante también para "Caballeros
  Hospitalarios", que pide Highlander en su Cuartel).
- Mecánica de "bandera inspiradora canadiense" ya modelada (`deAbilityInspiringFlagCanada`).
- NO se encontraron en esta pasada las techs `DEHCREVConscriptionCanada`/
  `DEHCREVCanadianOfficer`/`DEHCREVMetis`/`DEHCREVQuebec`/`DEHCREVFencibles` con su CONTENIDO
  detallado (solo se confirmó que EXISTEN como nombres de tech en `techtreey.xml`) — son
  probablemente cartas de Home City adicionales sobre la revolución base, no la revolución en
  sí. **Hace falta una segunda pasada de investigación específica sobre esas 5 techs +
  `DEHCHanoverAllies2`** antes de implementar, si se quiere usar exactamente lo que pidió el
  usuario (Voltigeur/Fencibles/tambores por 1 población) en vez de la mecánica real de
  "colonos armados + oso mascota".

## Particularidad (según el pedido — sin confirmar contra los 2 hallazgos de arriba)
- La Milicia no pierde puntos de resistencia (`DEHCREVConscriptionCanada`).
- Sin Explorador — civ oficial de milicia (`DEHCREVCanadianOfficer`).
- Sin Colonos — Exploradores Metis (`DEHCREVMetis`) ⚠️ (ambiguo, ver nota original).
- Capacidad de llamar milicianos desde Destacamentos y Fuertes (`DEHCREVQuebec`) + Cuarteles.

## Cuartel
- Voltigeur: Rangers.
- Defendibles (`DEHCREVFencibles`).
- Puede producir tambores/tamborileros por 1 de población (`DEHCHanoverAllies2`).

## Pendiente de definir antes de implementar
- **Decisión central**: ¿la civ nueva usa la mecánica REAL de `DERevolutionCanadaFrench`/
  `CanadaBritish` (colonos armados + oso mascota + Métis Pathfinder skin), o el diseño
  propio del usuario (Voltigeur/Fencibles/Conscription/Oficial de milicia) construido desde
  cero reusando solo la bandera real? Ambas son válidas pero son diseños distintos.
- Investigar a fondo el contenido de `DEHCREVConscriptionCanada`/`DEHCREVCanadianOfficer`/
  `DEHCREVMetis`/`DEHCREVQuebec`/`DEHCREVFencibles`/`DEHCHanoverAllies2` (solo se confirmó que
  existen, no su contenido).
- Civ base real a clonar: French o British (o ambas variantes, como Colombia).
- Rango de IDs propio.
- Aclarar la mecánica exacta de "colonos no, Exploradores metis".
