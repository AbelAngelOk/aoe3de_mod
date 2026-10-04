# Estados Pontificios (propuesta, sin implementar)

Sin base real especificada por el usuario todavía. Concepto central: **no tiene Cuartel,
Establo ni Artillería — todo sale del Centro Urbano**, que además reemplaza su modelo por el
de la Basílica.

## 🔎 Hallazgo clave (investigación 2026-09-09) — TODA la unidad del roster es real
No se encontró una "revolución Pontificia" dedicada (no hay `DERevolutionPapal` en los datos),
pero **cada unidad pedida corresponde a un proto real confirmado**, la mayoría mercenarios ya
disponibles vía la Basílica/consulado de varias civs europeas (de ahí el prefijo `DEPolitician
PapalGuard<Civ>` que aparece repetido para Español/Portugués/Sueco/Italiano/**Maltés** — el
Guardia Pontificio es contenido compartido entre muchas civs reales, no exclusivo de una):
- **Guardia Pontificio** = `dePapalGuard` (real, `tactics=papalguard.tactics`).
- **Schiavoni** = `Schiavone` (mercenario real, ya reutilizado en este mod para
  `HUNGrenzer`/`HUNPandur`, ver `docs/civs/05-hungria-otomana.md`/`06-hungria-alemana.md`).
- **Lanceros Pontificios** = `deNMPapalElmetto` (real, animfile
  `mercenaries\elmeti\papal_elmeti_horse.xml`, ícono "papal_lancer" — es la variante papal
  del Elmeti).
- **Zuavos Pontificios** = `deNMPapalZouave`/`deMercZouave` (real, animfile
  `mercenaries\zouave\papal_zouave.xml`).
- **Jinetes Negros** = `MercBlackRider` (real, ya reutilizado en este mod para Hungría).
- **Piqueros Suizos** = `MercSwissPikeman` (real).
- **Bombarda Pontificia** = `deNMPapalBombard` (real, `tactics=papalbombard.tactics`,
  mejora asociada real `DEImperialPapalBombard`).

Solo faltan por confirmar los protos reales de **Espías** (probable `xpSpy`, ya usado en
Argentina) y **Colonos/Sacerdotes** (`Settler`/`Priest` normales, sin necesidad de nada
especial). Con esto, el roster de 10 unidades pedido está prácticamente resuelto en su
totalidad — el trabajo de implementación sería sobre todo de REESTRUCTURACIÓN del Centro
Urbano (columnas, blocktrain, HP x3), no de inventar/clonar unidades desde cero.

## Estructura general
- Sin Cuartel, sin Establo, sin Artillería.
- Todas las unidades entrenan desde el Centro Urbano.
- El Centro Urbano usa el modelo de la Basílica (`deBasilica`, ver Iglesia/Basílica de Italia
  y Argentina en `docs/civs/03-argentina.md` — mismo tipo de cambio de modelo de building que
  ya se hizo una vez en este mod para el Establo de Egipto, `docs/civs/04-egipto.md`).
- El Centro Urbano tiene el **triple** de puntos de vida.

## El Centro Urbano debe producir
- Colonos.
- Sacerdotes.
- Espías.
- Guardias Pontificios.
- Schiavoni.
- Lanceros Pontificios.
- Zuavos Pontificios.
- Jinetes Negros.
- Piqueros Suizos.
- Bombarda Pontificia.
- Debe poder avanzar de edad (obvio para cualquier Centro Urbano, pero listado explícito por
  el usuario — probablemente para dejar claro que NO se pierde esa función pese a todos los
  demás cambios).

## El Centro Urbano NO tiene
- Revolución.
- Milicianos (sin la unidad de milicia que normalmente puede salir de un Centro Urbano
  atacado/en emergencia).

## El Centro Urbano puede
- Producir Colonos en grupos de hasta 5 (`<blocktrain>`, mismo mecanismo nativo ya usado en
  este mod para Dorobant/Hajduk de Rumania — ver `docs/civs/08-rumania.md`).
- Producir unidades militares en grupos de hasta 10 (mismo mecanismo, lote más grande).

## Pendiente de definir antes de implementar
- Civ base real a clonar (sigue sin definir — candidatos razonables: Italia, por la
  proximidad geográfica/histórica con la Basílica, o España/Portugal, que son las civs que
  más `DEPoliticianPapalGuard<Civ>` variantes tienen).
- Rango de IDs propio.
- ~~Confirmar proto real de cada unidad militar listada~~ → **resuelto casi al 100%, ver
  hallazgo arriba**. Solo falta confirmar Espía (`xpSpy`, probable) y decidir si Colono/
  Sacerdote son los protos normales o necesitan variante propia.
- Decidir cómo repartir TODO ese roster (10 tipos de unidad + Colono) en las columnas de un
  solo edificio — el Centro Urbano real no tiene tantos slots de `<train>` libres, puede
  requerir reestructurar su panel de construcción a fondo.
