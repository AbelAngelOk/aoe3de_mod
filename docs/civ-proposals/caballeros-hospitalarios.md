# Caballeros Hospitalarios — ✅ IMPLEMENTADA (v10.0)

**Ver el estado real en [`docs/civs/09-caballeros-hospitalarios.md`](../civs/09-caballeros-hospitalarios.md).**
Todo lo de más abajo es el registro histórico de la propuesta original — se conserva para
referencia, pero ya no representa el estado del mod.

## 🔎 Hallazgo clave (investigación 2026-09-09)
**Malta (`DEMaltese`) es una civilización REAL Y COMPLETA ya en el juego base** (`civs.xml`,
con su propia bandera `Flag_Maltese.png`/`Flag_Maltese_Cross.png`), no una revolución — tiene
Age0–Imperial propios (`DEAge0Maltese`...`DEPostImperialMaltese`), su propia unidad
**`deHospitaller`** (Caballero Hospitalario) con línea de mejoras real
(`DEVeteranHospitallers`/`DEGuardHospitallers`/`DEImperialHospitallers`), y variantes propias
de Mosquetero/Cañón (`deMalteseMusketeer`/`deMalteseGun`). **Recomendación: clonar `DEMaltese`
directo** (mismo patrón que Egipto clona Otomanos o Rumania clona Rusia) en vez de inventar la
civ desde cero — la mayor parte del trabajo (unidad Hospitalaria, bandera, políticos propios
`PoliticianAdmiralMaltese`/`PoliticianSergeantMaltese`/`PoliticianWarMinisterMaltese`) ya
existe hecha.

**"Morgan Black" SÍ es un nombre real** — pero es el héroe de campaña (SPC) de los Caballeros
de Malta (`SPCMorgan`/`IGCMorgan`, string 25278 = "Morgan Black", rollover 32463 = "Líder de
los Caballeros de San Juan de Malta"), NO un Explorador implementado como tal en ninguna tech
de civ jugable. También existe `DEPoliticianMorganBlack` (tech de consulado) y
`SPCMorganFlagship`. Usarlo como reemplazo de Explorador sería una REUTILIZACIÓN CREATIVA de
un asset de campaña ya existente (nombre/ícono/animación reales), no una implementación 1:1
ya hecha — hay que armar el proto de Explorador a mano reusando esos assets.

**Bonus de investigación**: `DERevolutionBarbaryStatesMalteseShadow` (una de las 4 variantes
de la revolución de Estados Berberiscos, ver `estados-berberiscos.md`) YA incluye
`deHospitaller`, `deMalteseMusketeer`, `Crossbowman`/`Pikeman` entrenables desde el Corsario
cuando la civ base es Malta — otra fuente real de referencia para el roster de esta civ.

## Inicio
- Sin Explorador. En su lugar: **Morgan Black** (⚠️ confirmar nombre real del proto/mercenario
  — no se identificó todavía en los datos, podría ser un personaje/skin de Explorador
  mercenario o pirata existente).

## Edificios
- La civilizacion base usa tiendas de campana en lugar de cuarteles, esta nueva civilizacion debe utilizar cuarteles.
- Los colonos tienen la lista de edificios debe actualizarse alli

## Cuartel
- Piqueros 
- Ballesteros
- Rodeleros
- Highlander

## Establo
- Húsar (escrito "ussar" en el pedido original)
- Lancero
- Conquistador

## Artillería
- Lanzador de fuego (⚠️ posible referencia a un lanzallamas/proyector de fuego — confirmar
  proto real, ej. algún mercenario con ataque de fuego).

## Baraja de cartas
- en holanda hay una carta que habilita los piqueros suizos, incluirla en la baraja de cartas. Deben habilitarse en Cuarteles y tiendas de camapana. 
- crear carta en I edad que reemplace los cuarteles por tiendas de campana. asegurarse que construyan las mismas unidades que las definidas para cuartel

## Explorador
-  **Morgan Black** es la unidad utilizada en el modo historia. Copiar modelo y habilidades usadas en la camapana. 
