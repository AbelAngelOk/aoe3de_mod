# Changelog — Eastern European Expansion (EEX)

## [mod-minimal 6.6] — 2026-08-30 (Dos civs nuevas: Hungría Otomana e Hungría Alemana)

- **Hungría Otomana** (`HOTHungary`, clon de Otomanos, IDs 88885xxx): Cuartel con Hajduk +
  Grenzer propios (fuera Azap); Establo con Crabat + Hussar Magiar propios (fuera Arquero a
  Caballo y Deli, que compartían columna); Fundición de Artillería con Granadero Húngaro
  (fuera Humbaraci y Obús/AbusGun). Cartas: fuera Azap/Humbaraci/AbusGun; dentro Hajduk y
  Crabat (reutilizando las cartas ya existentes de Hungría) y una serie nueva de Granadero
  Húngaro (`HUNShipGrenadier1/2/Repeat`, equivalente a las 3 cartas reales de Humbaraci:
  5/7/6 unidades). Ciudad natal propia "Buda" (`homecityhotmin.xml`, clon de
  `homecityottomans.xml`), reusa la bandera real de Hungría con el buttonset/vistas de
  Otomanos.
- **Hungría Alemana** (`HGEHungary`, clon de Alemanes, IDs 88886xxx): Cuartel con Hajduk +
  Grenzer + Pandur propios (fuera Guerrillero/Skirmisher, cuya carta se reemplaza; también se
  deshabilita Piquero, que compartía columna con Hajduk); Establo con Crabat + Hussar Magiar
  (fuera Uhlan y Carro de Guerra, que compartían columna); Fundición de Artillería con
  Granadero Húngaro (fuera el Granadero base). Cartas: Hajduk y Crabat reutilizadas, Granadero
  Húngaro reutilizada de Hungría Otomana, y una serie nueva de Pandur
  (`HUNShipPandurs1-4`: 7/9/8/12 unidades) reemplazando las cartas reales de Guerrillero.
  Ciudad natal propia "Pozsony" (`homecityhgemin.xml`, clon de `homecitygerman.xml`).
- **Dos unidades propias nuevas, compartidas por ambas civs**: `HUNGrenzer` (tropa fronteriza
  húngaro-otomana, clon de `deNMPandour` sin el mecanismo nativo/Basílica, coste en recursos)
  y `HUNPandur` (irregular croata al servicio de los Habsburgo, clon de `deMercPandour` sin
  ser mercenario de Fortaleza, Edad 1). Ambas reutilizan arte/tactics/protoactions reales sin
  tocar; cada una con su línea Veterano/Guardia/Imperial propia y sonido plano nuevo
  (`hungrenzer_snds.xml`/`hunpandur_snds.xml`, reusando soundsets croatas reales — sin
  civlogic, evitando el bug de sonido documentado en v6.3-6.5).
- **Trampa de colisión de columna (nueva, no documentada antes en este mod)**: un proto
  agregado a un edificio compartido (Cuartel/Establo/Fundición) ocupa la MISMA columna para
  TODAS las civs que lo entrenan — si la civ base del clon deja algo activo en esa columna
  (ej. Deli para Otomanos, Uhlan/Carro de Guerra/Piquero para Alemanes), hay que
  deshabilitarlo explícitamente en el `Age0` de la civ nueva aunque el pedido original no lo
  mencione, o quedan dos unidades compitiendo por el mismo botón.

## [mod-minimal 6.5] — 2026-08-30 (El sonido "MM" tampoco alcanzaba: había que copiar el audio físico)

- **El colono seguía mudo en todas las civs pese al fix v6.3/6.4**: la hipótesis de v6.3 (que
  bastaba con registrar un soundset PROPIO, aunque apuntara por nombre de archivo suelto a un
  `.wav` vanilla como `spanishsmselect1.wav` sin copiarlo al mod) resultó **incompleta**. El
  motor no resuelve un `filename` de soundset contra el archivo vanilla si ese archivo no
  existe físicamente dentro de la carpeta `sound/` del propio mod — a diferencia de
  `animfile`/`icon`, que sí resuelven contra los assets base del juego sin copiarlos.
- **Fix real**: se confirmó que los `.wav` reales SÍ están disponibles en el dump local
  (`AoE3Reference/Sound/`, ~5600 archivos) — se copiaron los 210 `.wav` distintos que
  necesitaban los 99 soundsets `MM*` a `sound/mm/` (carpeta nueva, 16 MB) y se actualizaron
  todas las rutas `filename` de `soundsetsde.mods.xml` de `spanishsmselect1.wav` (suelto) a
  `mm\spanishsmselect1.wav` (relativo a la carpeta `sound/` del mod) — exactamente el mismo
  patrón que ya usa Hungría con sus propios mp3 (`hungary\explorer\...mp3`), que es el único
  caso confirmado funcionando desde el principio.
- Dos archivos (`DE\ThorRansomed.wav`, `DE\ThorRevived.wav`) no existen en ningún lado del
  dump — referencia huérfana en los datos vanilla (caso de borde rarísimo: solo aplica al
  skin "Thor" del Explorador sueco al ser rescatado/revivido). Se usa `ThorSelect1.wav` como
  respaldo en vez de dejarlos mudos.
- Esto reemplaza, con una base mucho más sólida (audio propio del mod, no una suposición sobre
  resolución de rutas), el fix de v6.3/6.4 para las 4 civs con voz personalizada.

## [mod-minimal 6.4] — 2026-08-30 (Egipto: sonido de Otomanos + correcciones)

- **Sonido de Colono, Explorador, Arquero a Caballo e Imam**: mismo patrón que Argentina (rama
  de civlogic sin `EGYEgypt`), corregido con el mismo mecanismo confirmado en v6.3 — soundsets
  propios `MMOttoman*`/`MMSahin*` registrados en `soundsetsde.mods.xml`, nunca el nombre
  vanilla directo. Se crearon `cavalryarcher_snds.mods.xml`/`imam_snds.mods.xml` (nuevos) y se
  agregó la rama a `settler_snds.mods.xml`/`explorer_snds.mods.xml` (ya existentes).
- **Establo sin sonido**: al ser `EGYStable` un proto 100% propio (clon del Stable real), le
  faltaba su propio archivo de sonido — creado `egystable_snds.xml` (plano, reusando los
  soundsets universales del Stable real, que no tiene civlogic).
- **Ícono de construcción del Establo**: revertido a los íconos reales del Stable
  (`stables_icon.png`/`stables_portrait.png`) — el pedido era cambiar solo el modelo 3D
  (animfile), no el ícono, que había quedado con el del Campamento de Guerra por error.
- **"Jinete a Camello Bereber" → "Jinete a Camello" + sin límite de creación**: el proto real
  `deNatCamelRider` nunca había recibido un `SetName` (se estaba usando su nombre vanilla), y
  su `buildlimit=9` nativo (pensado para su uso original nativo/mercenario) seguía activo — se
  agregó el `SetName` y se subió el límite a 999 (sin sentinela real de "infinito" en el motor).
- **Cartas de envío de Humbaraci eliminadas**: `DEHCShipHumbaracis1/2/Repeat` (las 3 cartas
  dedicadas exclusivamente a enviar `deHumbaraci`, ya deshabilitado para Egipto) sacadas del
  pool y de las entradas de layout de la Academia. Se dejó intacta `HCShipArtilleryDivision`
  por ser una carta mixta (1 Gran Bombarda + 6 Humbaraci) — no es una carta "de Humbaraci"
  propiamente, así que no se tocó pese a incluir algunos.
- **Nueva carta "División de Mamelucos"**: 8 Mamelucos por 2000 de oro, Edad IV, independiente
  de la cadena `EGYShipMameluke1-3/Team` ya existente.
- **Confirmado ya implementado** (no hacía falta agregarlo de nuevo): la carta "Reformas de
  Muhammad Ali" que quita el límite de creación de Nizam a cambio de eliminar a los Jenízaros
  ya estaba en el pool en Edad IV desde v6.0, correctamente conectada.

## [mod-minimal 6.3] — 2026-08-30 (Hallazgo crítico: el sonido reusado por nombre vanilla no funciona)

- **Causa raíz encontrada del Colono mudo (persistía tras reiniciar el juego)**: se confirmó
  en juego, con dos civs distintas (Finlandia Y Argentina), que agregar una rama nueva a un
  `<civlogic>` YA EXISTENTE apuntando a un soundset VANILLA por nombre (ej.
  `SpanishSettlerMaleSelect`) **no funciona** — el motor no lo resuelve, aunque la sintaxis
  sea idéntica a un caso confirmado funcionando (el Explorador de Hungría). La única
  diferencia real entre ambos casos: el de Hungría apunta a un soundset **registrado por el
  propio mod** (`soundsetsde.mods.xml`); los de Finlandia/Argentina apuntaban al nombre
  vanilla directo.
- **Fix aplicado a TODOS los archivos de sonido afectados** (8 en total): se registraron 70
  soundsets propios con prefijo `MM` (`MMSpanishSettlerMaleSelect`, `MMDESwedishExplorerSelect`,
  etc.) en `soundsetsde.mods.xml`, apuntando a los MISMOS `.wav` que ya usan los soundsets
  vanilla reales (sin grabar audio nuevo — se referencian igual que cualquier `animfile`/`icon`
  de un proto clonado). Se actualizaron las ramas de civlogic de `settler_snds.mods.xml`,
  `explorer_snds.mods.xml`, `halberdier_snds.mods.xml` (Finlandia y Argentina),
  `dragoon_snds.mods.xml`, `hussar_snds.mods.xml`, `priest_snds.mods.xml`,
  `xpspy_snds.mods.xml`, `musketeer_snds.mods.xml` (Argentina) y `destatemilitia_snds.mods.xml`
  (que además tenía el problema de agregar civlogic donde no había ninguno) para apuntar a
  `MM<Nombre>` en vez del nombre vanilla directo.
- Esto corrige de una sola vez, retroactivamente, TODOS los sonidos que se habían intentado
  arreglar en v4.4-v6.2 con el patrón (ahora confirmado roto) de reusar un nombre vanilla
  directo: Colono y Explorador de Finlandia, y Colono/Explorador/Dragón/Húsar/Sacerdote/
  Espía/Criollo/Gaucho de Argentina.

## [mod-minimal 6.2] — 2026-08-30 (Argentina: Gaucho/Gaucho a Caballo podían construir pero no recolectar)

- **Gaucho (`deStateMilitia`) y Gaucho a Caballo (`deREVGaucho`) podían construir Corrales y
  vacas pero no recolectarlas**: mismo patrón de bug que el de construir (v6.1) — el
  `ActionEnable` que se agregó ahí era solo de la acción "Build"; a la acción "Gather" le
  faltaba lo mismo: habilitarla (`ActionEnable`) Y darle una tasa de recolección
  (`WorkRate`), ya que ninguno de los dos protos trae una fila de `Gather` propia (son
  protos de combate puro). `Cow` comparte el `unittype` "Herdable" con `Sheep` (que
  cualquier villano ya sabe recolectar), así que alcanzó con agregar la tasa bajo esa misma
  categoría genérica en vez de una específica por `Cow`.
- Investigado (sin resolver) el reporte de que el Colono de Argentina sigue sin sonido pese
  al reinicio del juego: se descartaron encoding (UTF-8 sin BOM, igual que un archivo de
  Hungría ya establecido), manifiesto/indexado de archivos (no existe tal cosa en este mod),
  mod habilitado correctamente (confirmado en `age3-mod-status.json` y el log del juego), y
  el `<gameid>de</gameid>` de la civ (presente, igual que Finlandia). Se hizo una limpieza de
  caché más completa (`sp_ARGArgentina_homecity.xml` Y `-v11.dat`, este último no se había
  encontrado en limpiezas previas de esta civ). Causa raíz aún sin confirmar — pendiente de
  una prueba más para aislar si es específico de Argentina o si afecta también a la voz
  personalizada de otras civs de este mod.

## [mod-minimal 6.1] — 2026-08-30 (Argentina: más correcciones de sonido + habilidad de ganado)

- **Sacerdote y espía sin sonido**: mismo bug de siempre — `Priest` (el que Italia realmente
  habilita, no `Missionary`) y `xpSpy` usan `civlogic` sin rama `ARGArgentina`. Agregados
  `priest_snds.mods.xml` y `xpspy_snds.mods.xml` (nuevos) con soundsets `Spanish*`.
- **Gaucho (`deStateMilitia`) seguía sin sonido pese al intento anterior**: la hipótesis
  documentada en v5.1 se confirmó — `destatemilitia_snds.mods.xml` intentaba agregar
  `<civlogic>` a un archivo vanilla que nunca tuvo ninguno, y el motor no lo fusionó.
  Reescrito para sobreescribir DIRECTO el `<soundset>` plano existente (sin civlogic de por
  medio). Efecto colateral aceptado: al ser `deStateMilitia` un proto compartido, esto cambia
  su voz para cualquier civ que lo use, no solo Argentina — no hay forma de evitarlo sin que
  el archivo base tenga civlogic (el usuario permitió este compromiso explícitamente).
- **Colono sin sonido**: se verificó que la rama `ARGArgentina` en `settler_snds.mods.xml` ya
  estaba correctamente agregada y sincronizada desde v5.1 (mismo patrón que Explorador,
  confirmado funcionando para Hungría/Finlandia). No se encontró ningún error en el archivo —
  si el problema persiste tras esta sincronización, probablemente sea necesario reiniciar el
  juego (más allá de borrar la caché de savegame) para que recargue los sonidos del mod.
- **Gaucho a Caballo (`deREVGaucho`) sin la habilidad de recolección de ganado**: la tech real
  `DERevolutionArgentina` le da a `deREVGaucho`, además del rebalanceo de stats ya replicado
  en v5.0, la capacidad de construir Corrales y un acceso directo a "construir" una vaca
  (`ActionEnable` de Build + `CommandAdd` de `LivestockPen` y `Cow` sobre el propio proto) —
  esto no se había copiado. Agregado, dejando a Gaucho a Caballo con la misma capacidad
  económica que ya tenía el Gaucho de infantería (`deStateMilitia`).

## [mod-minimal 6.0] — 2026-08-30 (Egipto: 4ª civ, clon de Otomanos)

- **Nueva civilización `EGYEgypt`** (IDs 88884xxx), clon completo de Otomanos (civ real
  `Ottomans`, sin prefijo DE por ser civ base). Bandera: assets reales de `DERevEgypt`
  (`objects\flags\egyptian`); sin buttonset propio, se reusa `ottomanFlagBtn`.
- **Establo con modelo del Campamento de Guerra**: el `Stable` real es un proto COMPARTIDO
  por todas las civs — no se puede tocar su `animfile` sin reskinear a todo el mundo. Se creó
  un clon propio `EGYStable` (mismos stats, `animfile` del `deWarCamp` real de las civs
  africanas) y se reapuntó el botón "construir Establo" del Colono de Stable a EGYStable vía
  `CommandRemove`+`CommandAdd` (mismo slot nativo, page 6 columna 12).
- **Establo**: `deDeli` deshabilitado (+ `VeteranDelis` unobtainable), reemplazado por el
  Jinete a Camello real `deNatCamelRider` (rebalanceado de 0 a 2 población — su base es de un
  contexto nativo/mercenario). Se agregó `MercMameluke` real. `CavalryArcher` (la otra
  caballería nativa de Otomanos) se preservó sin cambios dentro del roster de `EGYStable`.
- **Fundición**: corregida una premisa — Otomanos NO usa el `Grenadier` genérico, usa su
  propio `deHumbaraci` (columna 1). Se deshabilitó `deHumbaraci` (+ sus mejoras
  `VeteranHumbaracis`/`RGBaratcuCorps`/`ImperialBaratcu`) y se agregó el Camello Catling real
  `deMercGatlingCamel` en su lugar.
- **Cuartel**: se agregó `deNizam` real como entrenable (columna 6, mismo slot que usa la
  tech real `ChurchTufanciCorps` para este proto) — su `buildlimit=20` nativo del proto ya
  cumple el pedido sin necesidad de un efecto aparte.
- **Carta "Reformas de Muhammad Ali"**: deshabilita `Janissary` (+ sus 3 mejoras) a cambio de
  quitarle el límite de creación a `deNizam` (`BuildLimit` a 999, sin sentinela real de
  "infinito" confirmado en el motor).
- **Cartas de Deli → Jinetes a Camello**: las 5 cartas reales (`DEHCShipDelis1-5`, con costo
  solo en "Ships", sin food/wood/gold) se reemplazaron por 5 réplicas propias
  (`EGYShipCamelRider1-5`) con la misma cadena de prerequisitos/edad/cantidad, enviando
  `deNatCamelRider`.
- **Cartas de Sipahi → Mamelucos**: de las 5 cartas reales (`HCShipSpahis1-4` +
  `HCShipSpahisTeam`, encadenadas en una sola cadena de prerequisitos, con costo en Food
  además de Ships), se mantuvo intacta `HCShipSpahis1` (Edad III, 3 unidades) como la única
  carta de Sipahis pedida. Las otras 4 se reemplazaron por una cadena propia
  (`EGYShipMameluke1/2/3/Team`) independiente de Sipahis1, con el mismo costo pero en Oro en
  vez de Food.
- **Sonido**: verificado que `deNatCamelRider`/`MercMameluke`/`deMercGatlingCamel`/`deNizam`
  no usan `civlogic` (voz universal) — no hicieron falta archivos de sonido nuevos.

### Notas de interpretación
- No existe un proto real "Sipahi" (con esa grafía) — el proto real es `Spahi`, una unidad
  exclusiva de envío por HC (no se entrena en ningún edificio para Otomanos jugable).
- `deNizam` tampoco se entrena de forma nativa en el Cuartel de Otomanos jugable (solo llega
  vía cartas reales) — la columna 6 usada acá es la misma que usa el juego base para este
  proto en otro contexto (`ChurchTufanciCorps`), reutilizada por consistencia.

## [mod-minimal 5.0] — 2026-08-30 (Argentina: 3ª civ, clon de Italia)

### Agregado
- **Nueva civilización `ARGArgentina`** (IDs 88883xxx), clon completo de Italia
  (`DEItalians`) — mismo patrón que Hungría/Finlandia: bloque `<civ>` copiado entero de
  `DEItalians` y age techs propios (`ARGAge0`/`ARGColonialize`/.../`ARGPostImperial`) que
  delegan por `TechStatus active` a los reales de Italia (`DEAge0Italians`, etc.).
  Bandera: se reusan los assets REALES de la civ de revolución `DERevArgentina` (ya
  existente en el juego base — botón "San Martín", `objects\flags\argentinian`,
  `Flag_Argentinian.png`) — no hizo falta arte nuevo.
- **Home city** (`homecityargentinamin.xml`): clon completo de `homecityitalians.xml`
  (visuales, pool de ~275 cartas, mazos, los 7 edificios de HC, waypoints), con el `<civ>`
  y los strings de nombre/héroe propios.
- **Iglesia común en vez de Basílica**: Italia habilita su Basílica única (`deBasilica`,
  `unittype AbstractChurch`) y nunca `Church`. Para Argentina se hace lo opuesto —
  `deBasilica` deshabilitada, `Church` habilitada junto con sus 7 techs estándar
  (`ChurchStandingArmy`, `ChurchMassCavalry`, etc.) que Italia nunca marca `obtainable`
  porque no las usa. Las 3 techs exclusivas de la Basílica italiana
  (`DEChurchCarabinieri`/`Risorgimento`/`Papacy`) quedan `unobtainable`.
- **Corrales producen vacas, no corderos**: se saca el training de `Sheep` del
  `LivestockPen` (`CommandRemove`, mismo patrón real que usan las civs asiáticas con su
  propio corral) y se agrega el de `Cow` (`AddTrain`, proto real ya preparado para esto —
  tiene su propia tasa de `Gather` en `LivestockPen`, solo que ningún building lo entrena
  por defecto).
- **Cuartel reorganizado**: se deshabilitan `dePavisier`/`Pikeman`/`Halberdier` (y sus
  mejoras) para liberar las columnas 0/1/2 nativas de Italia. Ahí se reposicionan tres
  protos REALES compartidos, renombrados por-jugador (`SetName`) y reubicados con
  `CommandRemove`+`CommandAdd` (no se puede agregar un `<train>` estático sin filtrar el
  botón a otras civs que también usan esos protos en su columna original — ver
  `aoe3-shared-proto-per-player-extend`):
  - **Gaucho** = `deStateMilitia` real (col 0). Además puede construir Corrales
    (`AddTrain LivestockPen` sobre el proto).
  - **Criollo** = `Musketeer` real (col 1, nativa es la 4). "No se producen mosqueteros"
    se cumple en el sentido de que ya no aparece nada llamado así — es el mismo proto,
    solo renombrado y reposicionado.
  - **Granadero** = `deSoldado` real de México (col 2).
- **Establo ampliado**: `Lancer` real deshabilitado (columna 1 nativa) y reemplazado por
  el clon propio `ARGLancer` (mismos stats, pero con el modelo/ícono del
  `deRevolutionaryScout` — no se puede tocar el `animfile` del `Lancer` real sin reskinear
  también a las demás civs que lo usan, ver `aoe3-unit-sounds-snds`/lección de modelos
  compartidos). Columnas 3 y 4: dos clones propios nuevos — **Gaucho a Caballo**
  (`ARGGauchoHorse`, basado en `deChinaco`, lancero montado mexicano) y **Granadero a
  Caballo** (`ARGGranaderoHorse`, basado en `Dragoon`, caballería con mosquete).
- **Cartas de envío de vacas**: Argentina no hereda ninguna carta de envío de colonos
  utilizable en juego normal — las 4 únicas techs de Italia que envían `Settler`
  (`DEHCREVCitizenship`, `DEHCREVCitizenshipOutpost`, `DEHCREVDhimma`,
  `DEHCREVImmigrantsEuropean`) están todas detrás de `<prereqtech>XPRevolution</prereqtech>`
  + `<revoltcard/>`, es decir son de un mazo de revolución inalcanzable en juego normal.
  Se agregaron 3 cartas propias `ARGShipCow1/2/3` (4/5/8 vacas, edades II/III/IV) siempre
  disponibles, como sustituto directo de "en vez de enviar un colono, envía una vaca".
- **Sonido**: `deStateMilitia`/`deSoldado`/`Lancer`/`deChinaco` tienen voz universal (sin
  `civlogic`) y ya funcionan para Argentina sin tocar nada. `Musketeer` sí usa `civlogic`
  — se agregó `sound/musketeer_snds.mods.xml` (aditivo) con una rama `ARGArgentina` que
  reusa los soundsets reales `SpanishMusketeer*` (pedido explícito: sonidos de España).
  Los 3 clones nuevos (`ARGLancer`/`ARGGauchoHorse`/`ARGGranaderoHorse`, protos propios)
  tienen su propio `_snds.xml` plano reusando `SpanishLancer*`/`SpanishDragoon*`.
- **IA**: `game/ai/sanmartin.personality` (forcedciv `ARGArgentina`) para que la civ sea
  jugable por la IA, mismo patrón que Hungría/Finlandia.

### Notas de interpretación
- No se craneó un modelo/animación 3D nuevo para ninguna unidad — todo reusa modelos
  reales existentes (deStateMilitia, Musketeer, deSoldado, deRevolutionaryScout, deChinaco,
  Dragoon), igual que la limitación ya documentada para Finlandia (no es viable crear
  geometría 3D nueva desde un mod de datos).
- `Culture` de la civ: `Mediterranean` (igual que Italia y México — no es literal, es la
  categoría amplia que usa el juego para el sur de Europa y Latinoamérica).

## [mod-minimal 5.1] — 2026-08-30 (Argentina: correcciones tras primera prueba)

- **Gaucho a Caballo y Granadero a Caballo pasan a ser protos REALES**: se descubrió que
  Argentina ya existe como opción de revolución para Italia en el juego base
  (`DERevolutionArgentina`), con sus propias unidades `deREVGaucho` y `deREVGranadero`. Se
  reemplazaron los clones `ARGGauchoHorse`/`ARGGranaderoHorse` (basados en deChinaco/Dragoon)
  por estos dos protos reales, siguiendo el mismo patrón de la tech real: `deREVGaucho` se
  rebalancea a 1 población y 120 madera/0 oro (su base, pensada para envío masivo de
  revolución, es 7 población/120 oro); `deREVGranadero` no necesita ajustes.
- **Sonido de Colono y Explorador para Argentina**: se agregó la rama `ARGArgentina` (con
  soundsets `Spanish*`) a `settler_snds.mods.xml` y `explorer_snds.mods.xml`, mismo mecanismo
  ya usado para Finlandia/Hungría en esos mismos archivos.
- **Sonido del Dragoon y del Húsar**: ambos son protos reales que Argentina hereda sin
  cambios de Italia en el Establo (columnas 0 y 2) y también usan `civlogic` sin rama
  `ARGArgentina` — mismo bug que Colono/Explorador. Se agregaron `dragoon_snds.mods.xml` y
  `hussar_snds.mods.xml` (nuevos) con soundsets `Spanish*`.
- **Sonido del Gaucho** (`deStateMilitia`) cambiado a `deEmboscador` (`DEMexicanSalteador*`)
  por pedido explícito, vía `destatemilitia_snds.mods.xml` — caso especial: el archivo vanilla
  de este proto no tenía `<civlogic>` en absoluto (sonido universal para todas las civs), así
  que este archivo introduce esa estructura por primera vez; no hay precedente confirmado de
  que el motor fusione bien un `<civlogic>` nuevo sobre un archivo base sin ninguno — pendiente
  de confirmar en juego.
- **Gaucho no podía usar el botón de construir Corrales ni tenía forma de generar vacas**:
  faltaba `ActionEnable` de la acción "Build" sobre `deStateMilitia` — el botón (`AddTrain`)
  aparecía pero la unidad no tenía la acción de construir habilitada, así que no funcionaba.
  Se corrigió replicando el patrón exacto que usa la tech real `DERevolutionArgentina` con su
  `deREVGaucho`: `ActionEnable` de Build + `CommandAdd` de `LivestockPen` sobre el proto +
  `CommandAdd` de `Cow` directo sobre el proto (acceso directo a "construir" una vaca, sin
  depender únicamente del Corral).
- **"Colono por tech" de Italia → vaca**: se descubrió que Italia tiene un bono de civ propio
  (no una carta) que envía 1 colono cada vez que se investiga CUALQUIER tecnología en la
  partida — registrado por `DEAge0Italians` vía `SetOnTechResearchedTech` apuntando a la tech
  real `DEShipItalianVillager`. Se creó una réplica propia `ARGShipCowOnTech` (mismo
  mecanismo, envía `Cow` en vez de `Settler`) y `ARGAge0` vuelve a registrar el gatillo
  apuntando a la réplica, sobrescribiendo el de Italia.

## [mod-minimal 4.4] — 2026-08-01 (Finlandia: corrección de bugs + Iglesia/Blocao ampliados)

### Bugs corregidos
- **Cartas de envío de Carelia** (`FINShipKarelian1-4`): enviaban `Skirmisher` (Guerrillero)
  en vez de `FINKarelianJaeger` — residuo del find-replace global de cuando se abandonaron las
  revoluciones. Las 4 cartas ahora entregan la unidad correcta.
- **Sonido de las unidades**: `finkarelianjaeger_snds.xml` estaba clonado de un Guerrillero
  real con lógica `civlogic` por civ (French/British/Dutch/...) que nunca incluía "DEFinnish",
  así que la civ quedaba en silencio total. Reescrito con la estructura plana de
  `hunhonved_snds.xml` (sin civlogic), reusando el soundset `FinnishHakkapeliittas*` — el mismo
  que el archivo original ya usaba para cuando Suecia entrena Guerrilleros. Se borró también
  `finsavolaxjaeger_snds.xml`, huérfano (apuntaba a un proto `FINSavolaxJaeger` que no existe;
  Savonia usa el `MercJaeger` real y conserva su sonido vanilla intacto).
- **Costo del Jaeger de Savonia mostraba 160 de madera** en vez de 80 madera + 80 oro: la carta
  réplica `FINRevSavolaxJaegers` duplicaba el efecto de costo (+80 madera) que `FINAge0` ya
  aplica, sumando 160. Se eliminó la réplica (pool, layout de Academia y referencia
  `obtainable` en `FINAge0`) por ser 100% redundante con lo ya armado a mano en `FINAge0`.
- **Recolección del Jaeger de Carelia**: se verificó el proto y la carta "Desierto Norteño" —
  ya estaban correctamente restringidos a solo madera desde el Cambio 43; no había bug real
  (la sincronización con la carpeta instalada del juego también coincidía). Puede haber sido
  una observación de una partida anterior a ese cambio.
- **Colonos y Explorador tampoco tenían sonido**: mismo mecanismo que el Jaeger de Carelia,
  pero aplicado a protos COMPARTIDOS en vez de propios. `settler_snds.xml` y
  `explorer_snds.xml` (vanilla) resuelven la voz por `<civlogic>` (rama por civ) y "DEFinnish"
  no existe en esa lista al ser una civ nueva. Se agregaron archivos ADITIVOS
  (`sound/settler_snds.mods.xml` nuevo, `sound/explorer_snds.mods.xml` extendido — mismo
  patrón que ya usa Hungría para su Explorador) con una rama `DEFinnish` que reusa los mismos
  soundsets que ya usa `DESwedish` en el juego base (Finlandia = clon de Suecia, mismo modelo).
  De paso se revisaron todas las demás unidades compartidas de Finlandia: `MercJaeger`,
  `deConsulateCounterJaeger`, `Strelet` y `deRussianMusketeer`/`deLeatherCannon` NO usan
  civlogic (voz universal, sin bug); **`Halberdier` sí lo usa y tenía el mismo problema** —
  corregido igual (`sound/halberdier_snds.mods.xml` nuevo). `deCounterDragoon` no tiene
  archivo de sonido propio (usa un fallback genérico de Dragón que sí tiene civlogic); no se
  tocó por no ser parte de lo reportado — si en el juego se confirma mudo, es el mismo patrón
  y se arregla igual.

### Cartas y unidades
- **Lansquenetes (Edad II)**: la carta de 4 unidades ahora cuesta 500 de oro (antes 250) y se
  renombra "Grupo de Lansquenetes". Nueva carta **"Contratación de Lansquenetes"**: envía 3 y
  además habilita entrenar Lansquenetes en el Cuartel y el Fuerte.
- **"Suomenlinna" (Edad II) eliminada** (`FINRevShipBlockhouses`): pool, layout de Academia y
  referencia `obtainable` en `FINAge0`.
- **Cañones de la Iglesia**: `FINChurchCannons` ahora envía 2 **Cañones de Cuero**
  (`deLeatherCannon`) en vez de 2 Cañones Rusos ("Gran Cañón"), y los habilita en el Blocao. El
  Cañón de Cuero se reactiva SOLO para ese contexto — sigue deshabilitado en la Fundición
  (Cambio 27).
- **3 mejoras nuevas para las unidades del Blocao** (Streltsy, Alabarderos, Rekruts, Cañón de
  Cuero): Veteranía del Blocao (Edad III, +20%), Guardia del Blocao (Edad IV, +35%, requiere la
  Veteranía activa), Ejército Imperial del Blocao (Edad V, +50%, requiere la Guardia activa).
  Las 3 se vuelven investigables recién tras jugar "Tratado de Hamina" (`FINCardChurchTreaty`),
  igual que las techs de envío de unidades. Solo modifican stats (sin `SetName`/`UpdateVisual`)
  para no arrastrar el cambio visual a otras civs que también usan estas unidades reales (p.
  ej. Rusia con Strelet/Rekrut).
- **Nueva carta "25 Mosqueteros del Norte"** (`deNatMercNorthernMusketeer`, Edad IV, plantilla
  calcada de `DEHCOldenburgAllies1`): además de enviar 25, habilita entrenar la unidad en el
  Blocao a costa de deshabilitar a los Streltsy y los Rekruts (elección exclusiva). Desbloqueada
  también por "Tratado de Hamina".
- **Jaeger de Contraataque**: la carta de 9 y la de 6 (ahora 8) pasan de Edad IV a Edad III.
- **Cajones de Edad I**: se elimina la de 1600 alimentos (`FINRevShipFoodCrates`, duplicaba
  costo de investigación sin aportar nada nuevo). Las de 1600 monedas, Taiga Finlandesa, 15
  Wapities y Moras se mueven a Edad V con envío infinito (`maxcount=-1` +
  `infiniteinlastage`, mismo mecanismo que ya usa "Lansquenetes infinitos").
- **Unidad inicial**: Finlandia ahora empieza también con 1 Jaeger de Carelia (además de los 7
  Colonos habituales).

### Limpieza
- Se quitaron las 3 referencias `obtainable` colgantes en `FINAge0` que apuntaban a las techs
  recién eliminadas (`FINRevSavolaxJaegers`/`FINRevShipBlockhouses`/`FINRevShipFoodCrates`).

## [mod-minimal 4.3] — 2026-07-26 (Finlandia: Savonia vuelve a sus stats propios)

Corrección sobre la 4.2: Savonia NO debía tener un rebalanceo artificial — se revirtió a sus
stats propios (MercJaeger real +5% vida, sin tocar daño) y la mejora Imperial pasa a Edad V
(Imperialize) con +50% limpio, mismo patrón que Honvéd/Hajduk.

- `FINImperialSavolaxJaeger`: prereq `Industrialize`→`Imperialize`, amounts 1.152/1.133→1.50/1.50,
  ícono actualizado a `imperial_infantry`.
- FINAge0: se quitó el debuff de daño (0.767) inventado en la 4.2; la vida vuelve al +5%
  original (250→262.5), sin tocar el daño base (30).

## [mod-minimal 4.2] — 2026-07-26 (Finlandia: balance de unidades + limpieza de cartas)

- **Jaeger de Carelia (balance)**: recolección restringida a solo madera (el resto — caza,
  minado, pesca, etc. — se restaura investigando la carta "Desierto Norteño",
  `FINRevNorthernWilderness`, ahora redirigida al proto propio). Base 120 HP / 15 daño a
  distancia; en Edad I el daño baja a ~8 (referencia: Coureur) y se recupera al llegar a
  Edad II. Línea de mejoras renombrada a `FINKarelianJaegerTier2/3/4` (Edad II/III/IV, +20%
  cada una, acumulativas, SIN Imperial) — con las 3: 192 HP / 24 daño en Edad IV.
- **Jaeger de Savonia (balance)**: base rebalanceado a 192 HP / ~23 daño ("sin mejora");
  nueva mejora única `FINImperialSavolaxJaeger` (+50%, investigable desde Edad IV) lleva a
  288 HP / ~34 daño. Ya se desbloqueaba en Edad III (`allowedage` base de `MercJaeger`).
- **Jaeger de Contraataque**: se quitó la mejora de Edad III (`FINVeteranCounterJaeger`) —
  quedan solo 2 niveles (Guardia en Edad IV, Imperial en Edad V), coherente con que la unidad
  recién se desbloquea en Edad IV. Corregido el ícono (mostraba uno de caçador) en las 4
  cartas de envío.
- **Dragón de Contraataque**: ya tenía exactamente 2 mejoras, sin cambios.
- **Cuartel**: se agregaron los 3 niveles del Carelio (columna 0) y la mejora de Savonia
  (columna 1) a la segunda fila del Cuartel.
- **Cartas eliminadas**: "Autonomía de Årmfelt" (`FINRevArmfeltsAutonomy`), "Academia de
  Turku" en Edad II (`FINRevTurkuAcademy`, duplicada con `FINCardTurkuAcademy` en Edad I),
  todas las que envían Granaderos (`DEHCREVLegionGrenadiers`, `HCShipGrenadiers3/4`) y
  "Lanzagranadas" (`DEHCHandMortar`) — tanto del pool como del layout de la Academia.
- **Alabarderos**: la carta de envío de Edad IV pasa de 24 a 13 unidades (tech + string +
  badge visual).
- **Fundición**: además de Granaderos (ya quitados en 4.1), se bloquearon las tecnologías de
  Cañones de Infantería (`deInfantryGuns`/`deImperialInfantryGuns`, heredadas de
  `DEAge0Swedish`).

Nota de interpretación: en el punto de Savonia el pedido original mencionaba "-20%" dos veces
(Edad III y Edad IV) además del "+50% Imperial" explícito — se priorizó el número explícito
(+50%, un solo nivel) por ser más específico; si la intención era dos niveles separados, avisar
para ajustar.

## [mod-minimal 4.1] — 2026-07-26 (Finlandia: orden del Cuartel, Iglesia y Fundición)

- **Jaeger de Carelia vuelve a ser un proto propio** (`FINKarelianJaeger`, revivido) para poder
  fijarlo en la columna 0 del Cuartel — un proto compartido (Skirmisher) no admite columna fija
  sin filtrar el botón a otras civs. Como el cambio de skin ya se había descartado junto con
  las revoluciones, no hay ninguna pérdida adicional; de yapa recupera su voz propia
  (`sound/finkarelianjaeger_snds.xml`, que había quedado huérfana desde el Cambio 31).
- **Cuartel reorganizado**: Jaeger de Carelia (columna 0), Jaeger de Savonia (columna 1,
  `MercJaeger` real, restaurado), Jaeger de Contraataque (columna 2).
- **Iglesia**: las 4 techs (Streltsy/Alabarderos/Rekluts/Cañones) se movieron a la fila 2
  (tercera fila). Streltsy, Alabarderos y Rekluts ahora también habilitan su unidad como
  entrenable en el Blocao (antes solo la enviaban). Se reemplazó "Gran Ducado de Finlandia"
  (envío mixto) por **`FINChurchCannons`**: envía 2 Cañones Rusos por 500 alimentos desde
  Edad II y los habilita entrenables en el Blocao desde esa misma edad.
- **Fundición**: se quitó el Granadero base (heredado de `DEAge0Swedish` → `DEGrenadierEnable`)
  y sus 3 mejoras para Finlandia.

## [mod-minimal 4.0] — 2026-07-26 (Finlandia: réplicas propias de las cartas de revolución)

Las 23 cartas seguían sin verse en el editor de mazos incluso tras quitar los `<revoltdeck>`.
En vez de seguir peleando con el mecanismo de visibilidad del pool plano, se crearon réplicas
propias, ubicadas en un edificio físico de la metrópoli para saber siempre dónde encontrarlas.

- **23 techs nuevas `FINRev*`** en `techtreemods.xml`: cada una activa la tech real
  correspondiente vía `TechStatus active` (mismo patrón que `FINAge0` con `DEAge0Swedish`) —
  mismo efecto, nombre e ícono reales (reutilizan el `displaynameid`/`rollovertextid` original,
  sin necesidad de strings nuevas), pero con nombre propio para no chocar con el mecanismo de
  `revoltdeck`.
- **Ubicadas en el edificio Academia** (filas y=9/10/11, junto a las cartas de envío de
  Carelia/Contraataque/mercenarios ya existentes ahí) — visibles caminando hasta ese edificio
  en la metrópoli.
- Pool de `homecityfinlandmin.xml` actualizado para referenciar las réplicas `FINRev*` en vez
  de las techs reales directamente.
- Siguen pendientes de filtrar los mismos dos casos de superposición (`FINRevNorthernWilderness`
  con la recolección/construcción del Carelio; `FINRevSavolaxJaegers` con el Jaeger de Savonia
  ya armado a mano) y `FINRevShipHakkapelits` (envía `deFinnishRider`, no habilitado en la civ).

## [mod-minimal 3.9] — 2026-07-26 (Finlandia: cartas invisibles — revoltdecks heredados)

- **Encontrada la causa real de que las cartas del pool no aparecieran en el editor de mazos**:
  `homecityfinlandmin.xml` conservaba 3 bloques `<revoltdeck>` heredados íntegros de clonar
  Suecia (uno genérico, uno de EEUU `DERevUSA`, uno de Finlandia `DERevFinland`) — vestigios de
  cuando la civ podía revolucionar. El motor parece tratar cualquier carta listada en un
  `<revoltdeck>` como "exclusiva de revolución" (invisible en el editor normal), sin importar
  si también está en el pool plano. Se eliminaron los 3 bloques por completo.
- Además se corrigieron 22 cartas del pool que habían quedado con
  `<prereqtech>XPRevolution</prereqtech>` + `<revoltcard>` (de cuando perseguíamos
  `InitiateRevolution`, ya abandonado) — nunca se iban a poder investigar así.
- **Nota de proceso**: al corregir esas 22 cartas con una regex, un error propio arrastró ~146
  cartas no relacionadas (incluidas cartas de la Revolución Americana heredadas de Suecia).
  Se detectó con `git diff` y se recuperó el contenido perdido reconstruyéndolo desde las
  líneas removidas del diff contra el último commit (`e657170`, muy anterior — todo el trabajo
  de v3.3 en adelante seguía sin commitear). Ver CHANGELOG del propio incidente en el historial
  de conversación; el archivo quedó validado (XML correcto, sin duplicados nuevos, cartas v3.3
  intactas).

## [mod-minimal 3.8] — 2026-07-26 (Finlandia: se abandonan las revoluciones, civ normal)

Las revoluciones (`FINRevolution`/`FINEndRevolution`, v3.6-3.7) no funcionaron bien probadas en
juego. Se abandona el enfoque por completo — Finlandia vuelve a ser una civilización estándar
que avanza de edad sin ninguna traba.

- **Se eliminaron `FINRevolution` y `FINEndRevolution`** (techs, listados en el Centro Urbano,
  `obtainable` en `FINAge0`). Sin `InitiateRevolution`/`RevertRevolution` en el mod.
- **Jaeger de Carelia = Skirmisher real, disponible desde Edad II** (`AllowedAge` fijado a 1
  vía `Assign`): habilitado, costo 100 madera, nombre propio, recolección/construcción
  completas (mismo patrón por-jugador ya usado antes), entrenable en el Cuartel (slot
  compartido de Skirmisher) y en el Centro Urbano (`CommandAdd`, mecanismo real del juego).
  **Sin `InitiateRevolution` no hay garantía de cambio de skin** — es un Skirmisher
  "reskineado" por nombre/costo/rol, no necesariamente por aspecto visual.
- **Dragón de Contraataque**: ya estaba correctamente desbloqueado en Edad IV (`allowedage`
  base del proto = 3); no requirió cambios.
- **Se agregaron las 23 cartas del mazo de la revolución real de Finlandia**
  (`<revoltdeck civ="DERevFinland">` en `homecityswedish.xml`) al pool de la civilización,
  con edades asignadas por criterio propio (económicas en Edad II, militares/medias en Edad
  III, navales/avanzadas en Edad IV, una de Edad V) — **pendiente de filtrar**. Dos casos a
  revisar en el filtro: `DEHCREVNothernWilderness` y `DEHCREVSavolaxJaegers` se superponen con
  mecanismos ya armados a mano en `FINAge0`; `DEHCREVShipHakkapelits` envía una unidad
  (`deFinnishRider`) que esta civ no tiene habilitada.

## [mod-minimal 3.7] — 2026-07-26 (Finlandia: "Fin de la Revolución" recupera el avance de edad)

Se encontró el mecanismo que usa México para sus revoluciones regionales: el efecto
`RevertRevolution` (+ `SetAge`) deshace el tope de edad de una revolución. Con esto, el tope de
edad de v3.6 deja de ser permanente.

- **Nueva tech `FINEndRevolution`** ("Fin de la Revolución"), investigable desde el **Centro
  Urbano** junto a `FINRevolution`, gris hasta haberla investigado. Prereq: `Colonialize`
  (genérico) + `FINRevolution` activa. Costo 1250/1250/1250 (mismo patrón que
  `DEReturnMXCentralAmerica`, la versión Edad II de México).
  - Efectos: `SetAge Age2` → `SetAge Age3` (recupera el avance de edad y salta directo a
    Edad III) + `RevertRevolution` (con mensajes propios de Finlandia).
  - El Jaeger de Carelia **mantiene** su capacidad de construir/recolectar para siempre (a
    pedido, difiere de México, que se la retira a su unidad revolucionaria equivalente al
    investigar el regreso).
- Documentado en memoria (`aoe3-revolution-mechanism`) el mecanismo completo de
  `RevertRevolution`/`SetAge`, con el ejemplo de México usado como referencia.

## [mod-minimal 3.6] — 2026-07-26 (Finlandia: revolución como tech propia, no hijack de edad)

Ajuste sobre la v3.5, tras confirmar en juego que el hijack del botón de Edad II rompía el
avance a Edad III (y posteriores) — **confirmado que el bloqueo es inherente al efecto
`InitiateRevolution` en sí** (no a los flags `RevoltTech`/`revolutionciv`: se probó quitarlos
y el bloqueo persistió). Es el mismo trade-off que toda revolución real del juego: ganás la
transformación a cambio de quedar tope en la edad en la que revolucionás.

- **`FINColonialize` vuelve a ser un age-up normal** (se revirtió el hijack de la v3.5).
- **Nueva tech `FINRevolution`**, investigable desde el **Centro Urbano** (no reemplaza nada):
  prereq genérico `Colonialize` (gris hasta Edad II, patrón estándar del mod) + costo
  350/350/350 (mismo patrón que las revoluciones regionales de México en Edad II,
  `DERevolutionMXCentralAmerica`/`BajaCalifornia`). Mismos efectos reales de
  `DERevolutionFinland` (`InitiateRevolution`, skin real, panel de construcción, etc.) — el
  jugador **elige** cuándo revolucionar y acepta el tope de edad; quien no la investiga sigue
  avanzando de edad con normalidad.
  - **El Colono NO se deshabilita** al revolucionar (a pedido, difiere de la revolución real).
- Ver `docs`/memoria `aoe3-revolution-mechanism` para el detalle completo de la investigación
  (por qué `DERevFinland` no es una civ jugable, cómo Suecia registra su propia revolución vía
  `<revoltdeck>`, y por qué se optó por listar la tech en un edificio en vez de perseguir la
  pantalla de Revolución real).

## [mod-minimal 3.5] — 2026-07-26 (Finlandia: Edad II dispara la revolución REAL)

Cambio de arquitectura grande: se abandona el intento de imitar el Karelian Jaeger a mano
(Cambio 31, v3.4) a favor de disparar la revolución REAL del juego (`InitiateRevolution`),
que es el único mecanismo que efectivamente cambia el skin de una unidad.

- **Retirado el Jaeger de Carelia del Cuartel y del Centro Urbano** y **el Jaeger de Savonia
  del Cuartel** (`FINAge0`/`protomods.xml`). Ya no son un mecanismo permanente desde el inicio
  de la partida.
- **Los Colonos recuperan la habilidad de construir** y su menú completo de edificios
  (revertido el Cambio 27/28).
- **`FINColonialize` (la tech de avanzar a Edad II) ahora dispara la revolución de Finlandia**
  en vez de un age-up normal: se portaron los efectos reales de `DERevolutionFinland` (juego
  base) — `InitiateRevolution`, `VeteranSkirmishersShadow`/`GuardSkirmishers` activas de
  una vez (sin investigación en el Cuartel), ícono/portrait reales (`CopyUnitPortraitAndIcon`
  desde `deIconREVKarelianJaeger`), nombre real "Jaeger carelio" (string 80890/80889 del juego
  base), panel de construcción (11 edificios, lista oficial de la revolución), y el Colono se
  deshabilita al revolucionar (como en el juego real) — el Skirmisher pasa a ser el
  constructor/recolector de la civ desde ese momento.
  - Riesgo asumido conscientemente: no hay precedente en el juego de que el botón normal de
    "avanzar de edad" dispare una revolución (las revoluciones normalmente se eligen desde la
    pantalla de Revolución de la metrópoli, disponibles recién en Edad IV con costo
    1000/1000/1000). Se decidió igual por pedido explícito, tras advertir el riesgo de que
    Finlandia quedara sin poder avanzar de edad si algo no encaja.
  - Se agregaron `<flag>RevoltTech</flag>` y `<revolutionciv>DERevFinland</revolutionciv>` a
    `FINColonialize` (todo tech con `InitiateRevolution` en el juego base los lleva).
  - Hallazgo técnico: `AllowedAge`/`Cost` con `relativity="Assign"` FIJAN el valor literal
    (no es un delta); confirmado con `DERevolutionFinland` (Cost Food/Gold/Wood con Assign) y
    con revoluciones de México a Edad II con costo 350/350/350 (precedente de que una
    revolución SÍ puede estar disponible desde Edad II, aunque elegida desde su propia
    pantalla, no reemplazando el botón de age-up).

## [mod-minimal 3.4] — 2026-07-25 (Finlandia: Carelia = Skirmisher real + mejoras Contraataque)

- **Jaeger de Carelia ahora ES el Skirmisher real** (ya no un proto clon propio). Causa: el
  cambio de skin veterano/guardia (`UpgradeTech` + `UpdateVisual`) solo se dispara sobre el
  proto BASE, nunca sobre un clon — confirmado comparando con `GuardSkirmishers` vanilla, que
  usa el mismo patrón exacto sin ningún efecto adicional de "cambio de modelo". Con este cambio,
  al investigar las mejoras del Cuartel el Carelio debería mostrar el skin gris de guardia real.
  - Todos los efectos (edad de aparición, costo, nombre, recolección, panel de construcción)
    se aplican **por-jugador** dentro de `FINAge0`, igual que ya hacía `DEChurchSavolaxJaegers`
    con `MercJaeger` — no afecta a Francia/Holanda/Alemania/España, que habilitan Skirmisher
    por su cuenta.
  - Panel de construcción: lista curada de 13 edificios (economía + militares clave) vía
    `AddTrain` por-jugador — en vez de editar el proto compartido `Skirmisher` en
    `protomods.xml` (eso sí filtraría el botón a otras civs).
  - Se retiró el proto propio `FINKarelianJaeger` (ya sin uso) y se actualizaron sus
    referencias (`civmods.xml` unidad inicial, cartas de envío, mejoras del Cuartel).
  - Efecto colateral positivo: al ser el Skirmisher real, el Carelio hereda su voz de combate
    real (el proto propio nunca tuvo sonidos configurados).
  - Savonia (`MercJaeger`) queda sin cambios: ya usaba el proto real, pero los mercenarios no
    tienen arte de veterancía en el juego base, así que su mejora sube estadísticas sin cambiar
    el aspecto (limitación del juego, no del mod).
- **Jaeger de Contraataque → Edad IV**: las 2 cartas que estaban en Edad III (`FINShipCounterJaeger1/2`) pasan a Edad IV, junto a las otras 2 que ya estaban ahí.
- **Mejoras del Cuartel/Establo para las unidades de consulado**: línea completa Veterano/
  Guardia/Imperial para Jaeger de Contraataque (`deConsulateCounterJaeger`, patrón infantería
  3 niveles) y Guardia/Imperial para Dragón de Contraataque (`deCounterDragoon`, patrón
  caballería 2 niveles, como Húsar Magyar/Crabat).
- **Centro Urbano entrena Jaeger de Carelia de a uno**: ya funcionaba (proto habilitado +
  costo definido); confirmado con la conversión a Skirmisher real.
- **Panel de construcción del Carelio**: en vez de un botón de alternar modo militar/colono
  (no existe esa función en los datos del juego), se curó la lista de ~20 edificios a 13
  (economía + militares clave) para que quepan en la grilla del panel.

## [mod-minimal 3.3] — 2026-08-01 (Finlandia: reorganización del mazo de metrópoli)

Rediseño grande del mazo finlandés reutilizando cartas/unidades oficiales del juego. Todo el
contenido nuevo vive en `techtreemods.xml` (rango de ids 88882xxx), `homecityfinlandmin.xml`
(pool + layout) y `strings/{spanish,english}/stringmods.xml`.

- **Cartas eliminadas** (pool + deck + layout + puente de prereqs): Duelista, Tratado de
  Roskilde, Fortificaciones extensas, Sistema de reparto (x2: `DEHCSoldierTorps` +
  `DEHCREVSoldierTorps`), Rebelión de Dalecarlia, Fuego de pelotón, Granaderos de línea,
  Aliados caribes, Contratar granaderos gigantes, Contratos de mercenarios alemanes,
  Contratar Jaegers de Hesse.
- **Carolinos → Jaegers de Carelia**: se quitaron las 4 cartas de Carolinos y se crearon 4
  equivalentes que envían `FINKarelianJaeger` con la misma edad/cantidad: III (8, 9), IV (16,
  10 infinita).
- **Jaegers de Contraataque** (nuevas, `deCounterJaeger`): III (5, 6), IV (9, 12).
- **Dragones de Contraataque** (nuevas, `deCounterDragoon`): III (5), IV (8, 9, 7 infinita).
- **Piqueros → Alabarderos**: se quitaron las 4 cartas de Piqueros y se crearon 4 de
  Alabarderos (`Halberdier`): II (4), III (7, 8), IV (24).
- **Landsknechts** (nuevas, modeladas en la alemana `HCMercsLandsknecht1German`): II (4, 250
  oro), III (10, 1000 oro), IV (10, 1000 oro, infinita).
- **Mercenarios ship-only**: se reemplazaron las cartas base de Brigadiers Irlandeses, Piqueros
  Suizos y Jinetes Negros por copias FIN que **solo envían** (mismo coste/edad/cantidad),
  quitando el efecto secundario que habilitaba entrenarlos en edificios (`CommandAdd`/`Enable`/
  `AddTrain`).
- **Cuartel — línea completa de mejoras** de Jaeger de Carelia y Jaeger de Savonia
  (Veterano/Guardia/Imperial), con el patrón estándar de infantería (`UpgradeTech` +
  `Hitpoints`/`SetName`/`UpdateVisual`/`Damage`).
  - **Corrección:** las 6 mejoras quedaban `UNOBTAINABLE` y la 2ª fila del Cuartel salía
    vacía. Ahora `FINAge0` las marca `TechStatus obtainable` (igual que `HUNAge0` con el
    Honvéd) y Guardia/Imperial encadenan con su tier anterior (`FINGuard…` requiere
    `FINVeteran…` activa; `FINImperial…` requiere `FINGuard…`).

Nota: las cartas de envío reutilizan el `displaynameid` de la unidad + `<displayunitcount>`
para el badge de cantidad (sin inventar strings de nombre). Ver
`docs/finland-jaeger-skins-pending.md` para la incógnita abierta del skin de los jaegers.

## [mod-minimal 3.2] — 2026-07-13 (Hungría y Finlandia jugables por la IA)

Ambas civs se podían elegir como jugador humano, pero **no aparecían al asignar civilización
a un oponente o aliado IA**. Causa: el selector de IA no se llena desde `civmods.xml` sino
desde las **personalidades de IA**, y cada una se ata a su civ con `<forcedciv>` (el juego trae
22 personalidades para sus 22 civs). No existía ninguna apuntando a nuestras civs.

- **`game/ai/`** — carpeta **nueva** en la raíz del mod (hermana de `data/` y `sound/`), el
  lugar donde un mod aporta personalidades de IA (patrón de los mods *Abstract Nations Plus* y
  *Baltic Mods*). Archivos en **UTF-8 con BOM**:
  - `corvinus.personality` → `<forcedciv>HUNHungarians</forcedciv>`, chatset `Frederick`
    (civ base Alemania), avatar `Flag_Hungarian.png`.
  - `stalhandske.personality` → `<forcedciv>DEFinnish</forcedciv>`, chatset `Gustav`
    (civ base Suecia), avatar `Flag_Finnish.png`.
- **Strings** 88881900/88881901 (Mátyás Corvinus) y 88882900/88882901 (Torsten Stålhandske)
  en español e inglés: nombre y tooltip del líder IA.
- El script de sincronización al mod local ahora también copia `game/`.

**Alcance conocido**: usan la IA base (`aiLoaderStandard`), que no conoce los protos ni las
cartas custom. Al ser clones de Alemania/Suecia juegan con normalidad usando las unidades base,
pero no entrenarán las propias. Una IA que las aproveche requiere copiar el árbol
`game/ai/core/*.xs` y registrar las civs en `aisetup.xs` / `aihccards.xs` — pendiente.

## [mod-minimal 3.1] — 2026-07-09 (Voces custom por civilización)

Integración de audio propio (mp3, el juego los acepta) para unidades húngaras, siguiendo
el patrón del mod "Just Poland". Archivos en `sound/hungary/<unidad>/`, soundsets aditivos
en `sound/soundsetsde.mods.xml` (root `<soundsetdefmods>`).

- **Explorador húngaro** (proto compartido `Explorer`): rama `HUNHungarians` en el
  `<civlogic>` vía `sound/explorer_snds.mods.xml` (root `<protounitsounddefmods>`, aditivo).
  Mapea Select, Move/Attack (Acknowledge), Claim, KnockOut, Ransomed, KnockOutRevived.
- **Honvéd** (proto propio `HUNHonved`): se edita directo su `hunhonved_snds.xml` (no hace
  falta civlogic). Voz basada en el mosquetero español: Select, Move, Attack.
- **Falconete** (proto compartido `Falconet`): rama `HUNHungarians` vía
  `sound/falconet_snds.mods.xml` (aditivo). Select, Move, Attack.

## [mod-minimal 3.0] — 2026-07-08/09 (2ª civilización: FINLANDIA, clon de Suecia)

### Fase 1 — Finlandia seleccionable (clon de `DESwedish`)
- `civmods.xml`: bloque **`DEFinnish`** (copia del sueco, statsid `FN`, bandera finlandesa
  reusada de `DERevFinland`, age techs `FIN*`). Rango de IDs **88882xxx**.
- `techtreemods.xml`: 7 age techs `FINAge0`…`FINImperialize` + post, que delegan a los
  `DE*Swedish` (mismo patrón que los `HUN*` con Germans).
- `homecityfinlandmin.xml` (**NUEVO**, clon del sueco) y
  `uitechtree/techtreedata_definnish.xml` (**NUEVO**, clon del árbol UI sueco).
- Strings ES/EN (88882001-004).

### Fase 2 — Unidades distintivas
- **Jaeger de Carelia** (`FINKarelianJaeger`): copia del "Jaeger Carelio" de la revolución
  finlandesa (= Skirmisher renombrado). Costo **100 madera**, **recolección completa**
  (tasas del colono), modelo skirmisher, icono `karelian_jaeger`. En Edad I tipo colono;
  en Edad II (`FINColonialize`) mejora "veterana" (vida/daño + SetName + UpdateVisual →
  skin de veterano).
- **Jaeger de Savonia** = **`MercJaeger`** (la unidad REAL que genera `DEChurchSavolaxJaegers`;
  "Savolax Jaeger" en inglés = "Jaeger de Savonia" en español, mismo unit). Se replica la
  church tech SIN el envío: rename a 91618, +vida/+daño (skin veterano), sigilo, costo madera.
- **Jaeger de Contraataque** = `deConsulateCounterJaeger` (consulado). Húsar/Arquero a
  Caballo/Dragón de Contraataque en el Establo.

### Rediseño del Cuartel finlandés
- Vaciado del roster sueco (Pikeman/Carolean/Crossbowman + sus mejoras deshabilitados en
  `FINAge0`, incluidas las de ballesteros). Quedan solo las 3 unidades propias arriba.

### Blockhouse / Sisu / cartas / mercenarios (Fases 3-4): PENDIENTES.

---

## [mod-minimal 2.7] — 2026-07-05 (Granadero propio en la Artillery Foundry)

### Artillery Foundry (`ArtilleryDepot`)
- **Quitado** (solo para Hungría, vía HUNAge0): la unidad **Granadero** base y sus techs
  (`VeteranGrenadiers`, `GuardGrenadiers`, `ImperialGrenadiers`, `RGPavlovGrenadiers`,
  `ImperialPavlovs`).
- **Agregado** `HUNGrenadier`: copia de `deNatHungarianGrenadier` (modelo húngaro, stats,
  ataques de granada) **sin** los tipos de consulado (`AbstractConsulateUnit` /
  `AbstractConsulateUnitColonial`) — así no recibe las mejoras automáticas por edad.
- **3 mejoras investigables en la Foundry** (reemplazan las del consulado): Veterano (III,
  +20%), Guardia (IV, +20%), Imperial (V, +50%), con prereq de edad genérico.
- Sonido propio `sound/hungrenadier_snds.xml`.

## [mod-minimal 2.6] — 2026-07-05 (Mercenarios, sonidos e iconos de carta)

### Sonido de unidades — FIX de raíz (toda la civ estaba muda)
- Causa: el sonido se resuelve por **nombre de proto** → `Sound/<nombre>_snds.xml`. Los
  protos HUN tienen nombres nuevos sin ese archivo → mudos (toda la civ).
- Creados 7 `_snds.xml` (Hajduk, Honvéd, Húsar Magiar, Crabat, Inf. Montada/Desmontada,
  Carretón) en `sound/` (raíz del mod, hermano de `data/`), copiando los soundsets de la
  unidad base. Voz del Hajduk = militar rumano (la del hajduk mercenario).

### Cartas de mercenarios (reemplazos y nuevas)
- **Quitadas 16 cartas** alemanas del mazo (Electores, Hohenzollern, Palatinos, Contratar
  lansquenetes/brigadiers/jaegers/bosniacos/elmeti, Oficio de soldado, Mercenarios de
  montaña, Lealtad mercenaria, 10/11 aliados Wettin, Granjeros alemanes, Escuela ecuestre).
- **Banda de lansquenetes → "Banda de Pandúros"** (6 pandúros, 250 oro).
- Nuevas: **Dieta de Presburgo** (EQUIPO ∞, 7 pandúros, 1000 oro, IV), **Apoyo de Jinetes
  Negros** (EQUIPO ∞, 5 jinetes, 2000 oro, IV), **Regimiento de Trenck** (EQUIPO, 4
  pandúros, 500 oro, III), **Arcabuceros a Caballo** (11, 1000 oro, IV).
- Protos usados: `deMercPandour`, `MercBlackRider`, `deMercHarquebusier`.

### Iconos de carta — buenas prácticas
- Descubierto que el juego **no** dibuja el marco ornamentado; se **hornea en el PNG**
  (verde=equipo, violeta=infinito). Los iconos de las 3 cartas de mercenario se rehacen
  como retrato limpio con el marco horneado, borrando el ∞/número (que el juego dibuja).
- Iconos de caballería (Resistencia/Combate/Corvinus) y borde de refuerzos convertidos a
  PNG 256px limpio desde la fuente HD.

### Hajduk
- Quitado el multiplicador x2 vs caballería (postura Melee).

---

## [mod-minimal 2.5] — 2026-07-04 (Cartas de caballería + tiempo de envío)

### Cartas de caballería (reemplazos en el mazo)
- **Resistencia de la caballería → "Resistencia de la Caballería"** (`HUNCardCavDefense`,
  reemplaza `HCCavalryHitpointsGerman`): **+15% de vida a toda la caballería**
  (`AbstractCavalry`). Icono `hun_card_high-cav_defense.png`.
- **Combate de la caballería → "Combate de la Caballería"** (`HUNCardCavStats`,
  reemplaza `HCCavalryCombatGerman`): **+15% de ataque y vida a toda la caballería**.
  Icono `hun_card_cav_stats.png`.
- **Caballería lipizzaner → "Legado del Corvinus"** (`HUNCardCorvinusLegacy`,
  reemplaza `HCUhlanCombatGerman`): **+20% de vida y ataque a la caballería pesada**
  (`AbstractHeavyCavalry`: Húsar Magiar + Infantería Montada; no el Crabat ligero).
  Icono `hun_card_high-cav_stats.png`.
- Iconos convertidos de assets (~2.5 MB) a **PNG 256px** limpio.

### Tiempo de envío
- Añadido `<researchpoints>40</researchpoints>` (tiempo estándar entre pedir y recibir
  el envío) a **todas** las cartas propias que no lo tenían (18 cartas) más las 3
  nuevas de caballería. Antes llegaban instantáneas.

---

## [mod-minimal 2.4] — 2026-07-04 (Refactor posturas Hajduk + infantería desmontada)

### Hajduk — posturas de combate (a, refactor)
- **Multiplicadores por postura, ahora inherentes al proto** (no dependen de carta):
  - **Normal** (Volley/Defend/StandGround): solo vs infantería pesada (x1.5) y ligera (x2).
  - **Stagger** (escalonado): solo vs artillería (x2) e infantería de asedio
    (`AbstractSiegeTrooper`, x2).
  - **Melee** (cuerpo a cuerpo): solo vs caballería (x2).
- **Armadura por postura** (carta Bocskai, corregida): añadidos slots base de armadura
  `Hand`/`Siege` al proto (sin ellos `TacticArmor` no aplicaba — era la causa del bug).
  Melee→`Hand`, Stagger→`Siege` (artillería), Normal→`Ranged`. Quitado el x2 artillería
  redundante de la carta (ahora inherente en Stagger).
- Nombres validados: armaduras `Hand`/`Ranged`/`Siege`; tipos `AbstractCavalry`,
  `AbstractArtillery`, `AbstractSiegeTrooper`, `AbstractHeavyInfantry`, `AbstractSkirmisher`.

### Infantería montada — desmontar + sin límite (g)
- Nueva unidad **`HUNMountedInfantryFoot`** (desmontada) desbloqueada por la carta en el
  **Cuartel**; la montada en el **Establo**.
- **Ambas sin límite de creación** (quitados `buildlimit`/`UseSharedBuildLimit`); en su
  lugar **cuestan 2 de población**.
- Tactics propias `hunMountedInfantryDismount` / `hunRiflemanMount` para que
  montar/desmontar transforme entre las dos unidades HUN (no la mercenaria base).

### Burgomaestre (j) — aura descartada
- El aura estilo tamborilero (boost de vida+ataque a cercanas) **no es data-moddable**:
  las auras de AoE3 DE están atadas por el motor a unidades específicas. Quitado el
  `HPAura` no funcional; la carta queda como **+50% vida/ataque al Héroe**.

---

## [mod-minimal 2.3] — 2026-07-04 (Lote a–j: cartas y mecánicas)

### Unidades
- **Crabat**: quitado el x2 vs artillería (b).
- **Hajduk**: costo base vuelve a **110 oro** (c). Nuevas **posturas de combate**
  (estilo fusilero Nizam, a): tactics propia `tactics/hunHajduk.tactics` con
  `StaggerRangedAttack` diferenciada + armadura `Hand` base. En **Melee**: sin bonos vs
  infantería común/ligera, **+x2 vs caballería**. En **Stagger**: sin bonos vs
  infantería común/ligera. (Carta Bocskai ya aplica armadura por postura.)
- **Infantería Montada** (`HUNMountedInfantry`, g): copia de `deNatMountedInfantryRider`
  sin lo mercenario, pop 2, habilitada por su carta y entrenable en el Establo.

### Cartas de metrópoli
- **Martillo malévolo → Teatros** (`DEHCTheaters`, existente) (d).
- **Campamentos mercenarios → Precios de Mercenarios**: Hajduk 40 alimento/70 oro,
  Crabat 90 alimento/90 oro (e).
- **Carretones de colonos → `HUNSettlerWagon`** (f).
- **Carretas de guerra → mezclas de caballería**: III = 2 Húsar + 3 Crabat; IV =
  4 Húsar + 5 Crabat (h).
- **Chevau-légers bávaros → Infantería Montada**: envía 9 y las habilita en el Establo,
  costo 500 oro (g). **Quitada** la carta "11 aliados de los Habsburgo" (g).

### Burgomaestre (j)
- Intento de aura estilo tamborilero: se habilita `HPAura` (regeneración por
  proximidad) en el Explorer vía la carta, además del +50% vida/ataque al Héroe.
  **Limitación**: un aura de *boost* de vida+ataque NO es data-moddable (las auras
  están atadas al motor a unidades específicas). A verificar en juego.

---

## [mod-minimal 2.2] — 2026-07-02 (Ajustes de cartas + envíos)

### Corregido
- **Carta "Ascensos de Élite"**: solo mostraba la UI de ascenso sin cambiar stats ni
  ícono de habilidad. Causa: `VeterancyEnable` habilita el rank-up, pero los protos ya
  no tenían `<veterancybonus>`. Restaurado el `<veterancybonus>` (bonos por rango) en
  `HUNHajduk` y `HUNCrabat`, **sin** `ExperienceUnit` (inactivo por defecto; la carta
  lo activa). *(A confirmar en juego que no ascienden sin la carta.)*
- **Iconos de "Distributivismo" y "Tala en el Extranjero"** (se veían en negro):
  ahora usan los iconos reales indios (`native\Distributivism.png`,
  `asians\Foreign_Logging.png`).

### Cambiado
- **`hcshipmentmodifier` 1.00 → 0.90**: envíos de metrópoli más baratos en XP (Hungría
  ya no recibe el bono de úlanos que encarecía los envíos alemanes).
- **"Distributivismo" → Edad I**, **"Tala en el Extranjero" → Edad II**.

---

## [mod-minimal 2.1] — 2026-07-02 (Cambio 7: Cartas de metrópoli)

### Envíos militares repuntados (nuevos techs `HUNShip*`, sin bono de úlanos)
- **Doppelsöldners → Húsares Magiares** (cantidad −1): 6 cartas.
- **Úlanos → Crabats** (cantidad −2): 5 cartas.
- **Guerrilleros (Skirmishers) → Hajduks** (misma cantidad): 4 cartas.
- **Ballesteros → Honvéds** (cantidad −3): 4 cartas.
- Cada carta ahora envía **solo** la unidad húngara (se elimina el "+N úlanos" de bono
  en esas cartas).

### Cartas eliminadas y reemplazadas
- **"1 Carretón Colono"** (`HCShipSettlerWagons1`): eliminada.
- **"Burgomaestre"** (`HCExplorerGerman`): eliminada → nueva carta Edad IV
  `HUNCardBurgomaster` (+50% vida y +50% ataque al Héroe). *(El aura queda para un
  paso posterior, según lo acordado.)*
- **"Reforma de Scharnhorst"** (`DEHCLandwehr`): eliminada → `HUNCardPromotions`
  (habilita la veterancía/ascenso de Hajduks y Crabats vía `VeterancyEnable`).
- **"Viaje de la Muerte"** (`DEHCDeathRide`): eliminada → `HUNCardMagyarPop` (reduce
  el costo de población de los Húsares Magiares a 2).

### Cartas nuevas (estilo civ india, adaptadas)
- **Distributivismo** (`HUNCardDistributism`): goteo de madera +1.25.
- **Tala en el Extranjero** (`HUNCardForeignLogging`): goteo de madera +2.35.

Strings 88881070–88881074. Se actualizaron el pool, los mazos preset y el layout
visual de la metrópoli.

> Pendiente/nota: el aura del Burgomaestre (paso siguiente). El "+N úlanos" de bono en
> las ~80 cartas NO militares no se pudo quitar civ-específicamente (son techs globales
> de Germans); solo se quitó en las cartas militares reemplazadas. `VeterancyEnable` a
> confirmar en juego.

---

## [mod-minimal 2.0] — 2026-07-02 (Cambio 6: Caballería propia — Establo)

Roster de caballería propio de Hungría en el Establo.

### Quitado (civ-específico, en `HUNAge0`)
- Caballería alemana del Establo: `Uhlan`, `WarWagon` (deshabilitadas) y sus mejoras
  (`VeteranUhlans`, `RGCzapkaUhlans`, `ImperialCzapkaUhlans`, `ImperialWarWagons`,
  `GuardWarWagons`) → `unobtainable`.

### Agregado (`protomods.xml`)
- **`HUNMagyarHussar`** (id/dbid 88881204): copia del Húsar Magiar base
  (`deLegionMagyarHussar`) — modelo, stats, audio, tactics. **3 de población** (ya lo era).
- **`HUNCrabat`** (id/dbid 88881205): copia del Crabat mercenario (`deSaloonCrabat`)
  **sin** el atributo mercenario/outlaw, **2 de población** (antes 4), **sin ascensos**
  (quitados `<veterancybonus>` y `<flag>ExperienceUnit</flag>`). Multiplicadores nuevos:
  cuerpo a cuerpo **x3 vs Infantería**; a distancia **x3 vs Caballería** y **x2 vs Artillería**.
- Establo (`mergeMode='modify'`): botones de train (Húsar Magiar col 0, Crabat col 1)
  + botones de mejora (página 1).
- **4 mejoras de caballería** (`techtreemods.xml`, dbids 88881307–88881310), 2 niveles
  cada unidad: Guardia en **IV** (+20% vida y ataque) e Imperial en **V** (+50%). **Nada
  en III.** Prereqs de edad genéricos (visible/bloqueada), renombran la unidad (`SetName`).
  Sin cambio de velocidad. Strings 88881040–88881063.

> Nota: "defensa" se interpretó como **vida (HP)**, igual que las mejoras de infantería.

---

## [mod-minimal 1.9] — 2026-07-02 (Retrato 256×256 + fix gating "visible/bloqueada")

### Cambiado
- **Retrato del Honvéd** (`honved.png`): **256×256** llenando todo el marco, mejor
  calidad (antes 64×64).
- **Gating de mejoras** — fix del "visible pero bloqueada": los prereqs de EDAD de
  las 6 mejoras pasan de los marcadores alemanes (`FortressizeGerman`, etc.) a los
  **genéricos** (`Fortressize`/`Industrialize`/`Imperialize`). El juego reconoce los
  genéricos como "requisito de edad" y muestra la mejora en gris/bloqueada antes de
  la edad (como las mejoras base). Hungría los activa vía la cadena alemana, así que
  el gating por edad sigue igual. Los prereqs de cadena (Veterano→Guardia→Imperial)
  se mantienen. **A confirmar en juego.**

---

## [mod-minimal 1.8] — 2026-07-02 (Ajustes de mejoras + retrato Honvéd)

### Cambiado
- **Retrato del Honvéd** (`honved.png`): ahora **64×64 llenando todo el marco** (sin
  margen transparente). Fuente: `honved.png` de la raíz (intacta).
- **Mejoras de cuartel** (Honvéd y Hajduk):
  - Velocidad por nivel **+0.15 → +0.10**.
  - Cada nivel ahora **renombra la unidad** (`SetName`) a su rango (Honvéd/Hajduk
    Veterano → de la Guardia → Imperial); ya no queda "Honvéd"/"Hajduk" a secas.
  - Strings de mejora en inglés a singular (sirven de nombre de unidad); rollovers
    actualizados a +0.10.
- Confirmado el gating "visible pero bloqueada": las 3 mejoras comparten slot; se ve
  solo la siguiente de la cadena, bloqueada por edad (Veterano→III, Guardia→IV,
  Imperial→V) hasta poder investigarla. (Ya estaba así desde 1.7; documentado.)

---

## [mod-minimal 1.7] — 2026-07-02 (Cambio 4: mejoras de cuartel propias)

### Quitado
- Las mejoras alemanas del cuartel (Veteran/Guard/Imperial de Crossbowman, Skirmisher,
  Pikeman, Dopplesoldner + Needle Gun) ya no aparecen para Hungría: se marcan
  `unobtainable` en `HUNAge0` (14 techs). Ya no correspondían a ninguna unidad del
  cuartel húngaro.

### Agregado
- **6 techs de mejora propias** (2 ramas × 3 niveles), `HUNVeteran/Guard/Imperial` +
  `Honved`/`Hajduk` (dbids 88881301–88881306):
  - Niveles 1 y 2: **+20%** vida y ataque, **+0.15** velocidad.
  - Nivel 3 (Imperial): **+50%** vida y ataque, **+0.15** velocidad.
  - Progresión acumulativa: Veterano (Fortaleza) → Guardia (Industrial, requiere
    Veterano) → Imperial (Imperial, requiere Guardia).
  - Nombres estilo estándar (Veterano/Guardia/Imperial), strings 88881020–88881025
    (+ rollovers 88881030–88881035) en inglés y español.
  - Botones agregados al `Barracks` (página 1) alineados bajo cada unidad; entradas
    en el diagrama del árbol de tecnología.

### Cambiado
- Orden del cuartel: **Honvéd primero, Hajduk segundo** (`train` col 0 y col 1).

---

## [mod-minimal 1.6] — 2026-07-02 (Hajduk: quitar UI de ascenso)

### Corregido
- El `HUNHajduk` seguía mostrando la UI de ascenso al abatir enemigos (acumulaba
  rangos sin beneficio). Causa: se había quitado el `<veterancybonus>` pero **no** el
  `<flag>ExperienceUnit</flag>`, que es el que hace acumular XP y ascender de rango.
  Eliminado ese flag → el Hajduk ya no asciende ni muestra la UI. (Validado: las 29
  unidades del juego base que ascienden tienen ambos; el Musketeer estándar no tiene
  ninguno.) Ambos —flag y veterancybonus— se re-agregarán a futuro con una carta.

---

## [mod-minimal 1.5] — 2026-07-02 (Honvéd: modelo camisa roja + icono con marco)

### Agregado
- `honved64.png` (64×64 con marco) como `<icon>` del Honvéd (botón del cuartel).

### Cambiado
- Modelo 3D del `HUNHonved`: de la casaca roja del consulado a la **"camisa roja"**
  (Redshirt/Garibaldini = `deColonialMilitia`, `units\infantry_ranged\colonial_militia\redshirt.xml`),
  la unidad que en el juego base solo aparece en el editor de escenarios.
- `<portraiticon>` del Honvéd sigue usando `honved.png` (retrato grande sin marco);
  `<icon>` ahora usa `honved64.png` (con marco).

---

## [mod-minimal 1.4] — 2026-07-02 (Honvéd: icono propio + modelo casaca roja)

### Agregado
- **Icono/retrato personalizado del Honvéd**: `honved.png` (retrato húngaro con chacó
  y dolmán) en `data\wpfg\resources\images\icons\hungary\honved.png`, referenciado en
  `<icon>`/`<portraiticon>` del proto `HUNHonved`. Primer asset propio del mod.
  (Convención de iconos de mod: `data\wpfg\resources\images\icons\…`.)

### Cambiado
- Modelo 3D del `HUNHonved`: de skirmisher del consulado a **casaca roja del consulado**
  (`units\asians\consulate\musketeer\musketeer.xml`) — animfile de mosquetero, acorde
  al rol melee+ranged del Honvéd, y con librea roja acorde al retrato.

---

## [mod-minimal 1.3] — 2026-07-01 (Cambio 3: Honvéd + Hajduk con stats de mercenario)

Reemplazo del mosquetero y del hajduk provisional por unidades con arte y stats
propios. Detalle en `mod-minimal/README.md` (sección "Cambio 3").

### Agregado
- **`HUNHonved`** (`protomods.xml`, id/dbid 88881203): el "mosquetero" de Hungría.
  Copia exacta del proto `Musketeer` base (todas sus stats) con el modelo/imagen del
  **fusilero de aguja prusiano** (`units\asians\consulate\skirmisher\skirmisher.xml` +
  iconos del skirmisher) y nombre **Honvéd**. Strings `88881013`–`88881015`.

### Cambiado
- **`HUNHajduk`** rehecho a partir del **Hajduk mercenario** del juego base
  (`deSaloonHajduk`): conserva modelo, iconos, 110 HP, carga cuerpo a cuerpo y todos
  los multiplicadores de daño. Excepciones pedidas: **no** es mercenario/outlaw
  (quitados los `unittype` de outlaw), cuesta **60 alimento + 60 oro** (antes 110 oro),
  **1 de población** (antes 3) y **sin veterancía/ascenso** (bloque `<veterancybonus>`
  eliminado; se recuperará a futuro con una carta).
- `HUNAge0` habilita `HUNHonved` + `HUNHajduk` (antes `Musketeer` base + Hajduk
  provisional). El cuartel de Hungría muestra solo esas dos unidades.
- `Barracks` (`protomods.xml`): botones de train de `HUNHonved` y `HUNHajduk`.
- `uitechtree`: grupo del cuartel actualizado a Honvéd + Hajduk.

---

## [mod-minimal 1.2] — 2026-07-01 (Cambio 2: roster de cuartel propio)

El cuartel de Hungría produce únicamente **mosqueteros y hajduks**. Detalle en
`mod-minimal/README.md` (sección "Cambio 2").

### Agregado
- **`HUNHajduk`** (`protomods.xml`, id/dbid 88881202): infantería propia de Hungría,
  mosquetero-reskin (90 HP, 60 alimento + 20 madera, `AbstractMusketeer`) que
  reutiliza animaciones/iconos del Musketeer base. Botón agregado al `Barracks`.
- Strings del Hajduk (`88881010`–`88881012`) en inglés y español.

### Cambiado
- `HUNAge0`: deshabilita la infantería de cuartel alemana (`Crossbowman`,
  `Skirmisher`, `Pikeman`, `Dopplesoldner`) y habilita `Musketeer` + `HUNHajduk`
  (civ-específico) → el cuartel muestra solo esas dos unidades.
- `uitechtree/techtreedata_hunhungarians.xml`: grupo del cuartel actualizado a
  Mosquetero + Hajduk.

---

## [mod-minimal 1.1] — 2026-07-01 (Cambio 1 de gameplay: colonos → carretones)

Primer cambio de jugabilidad propia de Hungría, sin assets nuevos y sin afectar a
Alemania ni a otras civs. Detalle en `mod-minimal/README.md` (sección "Cambio 1").

### Agregado
- **`protomods.xml`** (nuevo): `HUNSettlerWagon`, copia civ-específica del proto
  base `SettlerWagon` (id/dbid 88881201) con `buildlimit=50`. Modificación del
  `TownCenter` (`mergeMode='modify'`) para agregar su botón de train.

### Cambiado
- Hungría entrena **carretones de colonos** (`HUNSettlerWagon`, 100 alimento + 100
  madera, máx. 50) en lugar de colonos: `Settler` deshabilitado y `HUNSettlerWagon`
  habilitado en el tech `HUNAge0` (civ-específico).
- **Barcos pesqueros** con límite propio de 50 (`FishingBoat BuildLimit=50` en
  `HUNAge0`), como cap independiente del de carretones.
- Unidades iniciales de `civmods.xml` (`townstartingunit` / `empirewarsstartingunit`)
  cambiadas de `SettlerWagon` a `HUNSettlerWagon`.
- `uitechtree/techtreedata_hunhungarians.xml`: la ficha de `Settler` del diagrama
  reemplazada por `HUNSettlerWagon`.

---

## [mod-minimal 1.0] — 2026-07-01 (✅ Civilización funcional confirmada en juego)

MRE (`mod-minimal`) — civilización **Hungría (`HUNHungarians`)** seleccionable y
jugable en Escaramuza. Clon completo de Germans con identidad propia. Documentación
completa en `mod-minimal/README.md`; historial de depuración en
`docs/mre-hungary-report.md`.

### Agregado
- **Metrópoli completa** (`homecityhungarymin.xml`): 211 cartas y 6 barajas
  (incluida la default), copiadas de Germans.
- **Árbol de tecnología** (`uitechtree/techtreedata_hunhungarians.xml`): layout UI
  copiado de Germans.
- **Techs de edad propios** (`techtreemods.xml`): 7 techs (`HUNAge0`…`HUNPostImperial`,
  dbids 88881101–88881107) que delegan por `TechStatus active` en los de Germans.
- **Strings en español** (`strings/spanish/stringmods.xml`): el juego solo carga el
  idioma del locale activo.

### Corregido (secuencia de bugs hasta la versión funcional)
1. `agetech` de Age1 apuntaba a `ColonizeGerman` (inexistente) → `ColonializeGerman`.
2. Faltaban los campos WPF de bandera/botón en `civmods.xml` (el selector WPF los
   requiere) → agregados, reutilizando assets de `DERevHungary` y Germans.
3. `civmods.xml` no tenía el bloque completo de una civ base → igualado 1:1 a Germans.
4. Faltaba `strings/spanish/` → creado (el juego corre en español).
5. La civ compartía literalmente los techs de Germans por nombre → techs propios.
6. **Causa final del bloqueo**: caché obsoleta en `Savegame\sp_HUNHungarians_homecity.xml`
   / `-v11.dat` de versiones rotas anteriores impedía que la civ se mostrara en las
   pantallas WPF pese a tener los datos correctos → borrada. Además, se desactivó el
   mod EEX (`localmod2`) para evitar colisión de nombre visible.

---

## [0.2.0] — 2026-06-27 (Bugfix crítico)

### Corregido
- **Mismatch de nombres de age techs** (bug crítico — civ no cargaba): civmods.xml usaba
  `EEXFortressizeHungary`/`EEXImperializeHungary` pero techtreemods.xml los definía como
  `EEXFortifyHungary`/`EEXEmpowerHungary`. Renombrados en techtreemods.xml para coincidir.
  Mismo arreglo para Romania (EEXFortressizeRomania, EEXImperializeRomania) y Finland.

- **Age0 techs incompletos** (bug crítico — no había edificios ni unidades): Los 3 techs
  Age0 (Hungary, Romania, Finland) ahora incluyen:
  - Todos los enables de edificios estándar europeos: TownCenter, HouseEast, Sheep, Capitol,
    ArtilleryDepot, Barracks, Stable, Plantation, TradingPost, Market, Arsenal, Outpost,
    Dock, CWallGate, WallStraight2/5/WallConnector, deTavern
  - Todas las unidades estándar: Settler, Priest, FieldHospital, Falconet, Culverin, Mortar,
    xpHorseArtillery, xpPetard, FishingBoat, Caravel, Galleon, Frigate, Monitor, xpSpy
  - Techs de sistema: XPTrickle, AAStandardStartingTechs, DEEuropeanStandardTechs, Levy
  - Techs imperiales/navales obtenibles: ImperialCannon, ImperialFieldGun, FieldGun, Bayonet,
    ImperialManOWar, ImperialMonitors, ImperialHorseArtillery, HeavyHorseArtillery
  - Techs de revolución obtenibles

- **Políticos no aparecían en TownCenter** (bug crítico): Todos los políticos de todas las
  edades (Colonial + Fortress + Industrial + Imperial) ahora son `obtainable` desde Age0.
  Antes estaban incorrectamente gateados por los shadow techs de cada edad.

- **Referencias a techs inexistentes** (crash al cargar): Eliminadas las referencias a
  `ColonizeShadow`, `FortifyShadow`, `IndustrializeShadow`, `EmpowerShadow` en los shadow
  techs de edad — esos nombres no existen en el juego base.

- **Nombre de edificio incorrecto**: `"Artillery Foundry"` → `ArtilleryDepot` (nombre interno correcto)

- **Nombres incorrectos en proto enables**: Eliminados `Church` y `Manor` de Age0 (nombres
  no verificados; `DEEuropeanStandardTechs` ya activa los edificios estándar)

- **Políticos no se eliminaban al subir de edad**: Agregadas entradas a `DERemoveAge3`,
  `DERemoveAge4`, `DERemoveAge5` con efectos `CommandRemove` (mergeMode="add") para las 3 civs.

- **Formato incorrecto en cartas de Home City**: El elemento `<name>` debe contener el nombre
  del tech directamente (ej: `<name>EEXHCShipHajduk3</name>`). No existe elemento `<tech>`
  separado. (Corregido en sesión anterior.)

### Documentación
- `docs/modding-reference.md`: Reescrito con el patrón correcto del Age0 tech, la lista
  completa de edificios a habilitar, el patrón de DERemoveAge, y la tabla de archivos
  additive de la documentación oficial de AoE3DE
- `TODO.md`: Actualizado para reflejar qué bugs fueron corregidos y qué queda por probar

---

## [0.1.0] — 2026-06-27 (Versión inicial)

### Agregado
- **Hungría (EEXHungary)**: Implementación completa
  - 5 unidades únicas: Hajduk, Pandur, Grenz Infantry, Magyar Hussar, Hungarian Dragoon
  - Árbol tecnológico Age0–Age4 (5 shadow techs de edad)
  - 12 techs de político (3 por nivel de edad)
  - 9 cartas de home city
  - Hungarian Explorer (animaciones alemanas)
  - Budapest home city (visuales alemanas)

- **Rumania (EEXRomania)**: Implementación completa
  - 5 unidades únicas: Dorobant, Romanian Pandur, Seimeni, Curteni, Romanian Explorer
  - Árbol tecnológico completo
  - 12 techs de político
  - 8 cartas de home city
  - Romanian Explorer (animaciones rusas)
  - Bucharest home city (visuales rusas)

- **Finlandia (EEXFinland)**: Implementación completa
  - 6 unidades únicas: Finnish Musketeer, Jaeger, Knekt, Hakkapeliitta, Finnish Dragoon, Finnish Explorer
  - Árbol tecnológico completo
  - 12 techs de político
  - 9 cartas de home city
  - Finnish Explorer (animaciones suecas)
  - Turku home city (visuales suecas)

- Upgrades Veteran/Guard/Imperial para todas las unidades
- Tabla de strings en inglés con nombres y descripciones completos
- Documentación: `docs/architecture.md`, `docs/civilization-design.md`, `docs/modding-reference.md`

### Técnico
- Todas las unidades reutilizan archivos de animación, iconos y tactics del juego base
- Rangos de IDs no colisionan con el mod de Polonia (77092xxx–77095xxx)
- Formato additive mod (mergeMode) para compatibilidad
