# Sudáfrica (propuesta, sin implementar)

## 🔎 Hallazgo clave (investigación 2026-09-09) — ⚠️ discrepancia importante
Existe `DERevolutionSouthAfrica` real (dbid 6437, displaynameid 80820 = **"Sudáfrica"**,
`revolutionciv=DERevSouthAfrica`, bandera real `objects\flags\south_african`,
`Flag_South_African.png`). **Su mecánica real NO coincide con el pedido** (no hay
piqueros/mosqueteros/guerrilleros/húsares/carretas de guerra/infantería montada en la tech
real):
- +10% de velocidad de recolección en TODOS los recursos terrestres y en pesca/ballenas, y en
  el Autogather de oro del **Banco**.
- `PopulationCap=200`.
- Casas y Mansiones se transforman en `deREVStarTrekWagon` ("carromato explorador",
  entrenable desde Establo/Galeón/Fuerte Frontera) — mecánica de vivienda móvil/defensiva, no
  de roster militar.
- **Habilita el Banco** (`Enable=1`) — confirma que "Bancos" es un tema real y central de
  esta civ, coherente con el pedido del usuario sobre límites de Banco.
- Existe una shadow tech real **`DEREVSouthAfricaBritishBankShadow`** (dbid 10588, prereq
  `DERevolutionSouthAfrica` + `Age0British` activos) que fija `BuildLimit=2` en `Bank` y mueve
  el comando de construir Banco del Colono al Explorador — **precedente real EXACTO** del
  patrón "ajustar el límite de Banco según la civ base de origen" que pediste.

**Las 4 cartas de límite de Banco (+2/+1/+1/+2) — no se encontró ese patrón exacto, pero sí
varios precedentes reales de cartas/techs con `BuildLimit` sobre `Bank`** que podés usar como
plantilla directa:
- `HCBanks1` (Home City, ícono "Banco de Ámsterdam"): `BuildLimit +1`.
- `HCBanks2` (Home City, ícono "Banco de Róterdam"): `BuildLimit +1`.
- `DEHCREVBankWagons` (Home City, específica de REVOLUCIÓN, flag `DECheckBuildLimit`): envía
  2 `BankWagon` gratis + `BuildLimit +2` — la más parecida a lo que describís.
- `DESPCBankOfAntwerp`: `BuildLimit +1`, pero es tech de campaña individual, no una carta de
  mazo normal — no usar como plantilla de multijugador.
- Techs de era (no cartas) que fijan el límite en 2 de forma similar: `ChurchCoffeeTrade`
  (holandesa), `ImpExcessiveTaxation`/`RevExcessiveTaxation`.

## Cuartel (según el pedido — sin precedente real confirmado, ver discrepancia arriba)
- Piqueros: usa "Piquetes" (`DEHCREVPickets` — confirmado que EXISTE como nombre de tech en
  `techtreey.xml`, dbid `10928`ish línea 160928, pero no se investigó su contenido a fondo).
- Mosqueteros.
- Guerrilleros.

## Establo
- Húsares.
- Carretas de Guerra.
- Infantería Montada.

## Bancos
- Pueden construir hasta 5 Bancos (base).
- +2 con una carta de la Iglesia → candidato real: **`DEHCREVBankWagons`**.
- +1 con otra carta → candidato real: **`HCBanks1`**.
- +1 con otra carta más → candidato real: **`HCBanks2`**.
- +2 con otra carta más → sin candidato exacto identificado todavía.
- Pueden tener hasta 3 Fábricas (Factory).
- Pueden tener hasta 3 Centros Urbanos + una carta que suma 2 más (total hasta 5).

## Colonos
- Tienen "Hugonotes": Coureurs de Bois (⚠️ sin resolver — nombre de sabor sobre un proto real,
  confirmar si es un renombre del colono normal o de una unidad adicional).
- Límite: 50.

## Pendiente de definir antes de implementar
- **Decisión central** (igual que Canadienses): ¿usar la mecánica REAL de
  `DERevolutionSouthAfrica` (economía +10%, StarTrekWagon, Banco habilitado) como base, o el
  diseño propio del usuario (Piqueros/Mosqueteros/Guerrilleros/Húsares/Carretas) construido
  desde cero reusando solo la bandera real y el patrón de Banco?
- Civ base real: la shadow `DEREVSouthAfricaBritishBankShadow` confirma que **Británica** es
  al menos una de las civs reales que puede revolucionar a Sudáfrica — usarla como base si se
  sigue el patrón real.
- Investigar contenido real de `DEHCREVPickets`.
- Identificar la 4ª carta de límite de Banco (+2, sin candidato encontrado).
- Confirmar mecánica exacta de "Hugonotes"/Coureurs de Bois.
