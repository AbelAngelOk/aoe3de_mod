# mod-minimal — Hungría (HUNHungarians)

Mod aditivo para **Age of Empires III: Definitive Edition** que agrega una nueva
civilización jugable, **Hungría** (`HUNHungarians`), seleccionable en Escaramuza,
Ciudades Natales y el editor de escenarios.

Es un clon completo y funcional de **Alemania (Germans)** bajo un nombre e
identificadores propios, reutilizando el 100 % de los assets del juego base (no
crea modelos, texturas, sonidos ni iconos nuevos). Sirve como esqueleto mínimo
verificado para agregar una civilización nueva sin contenido propio todavía.

> **Estado: FUNCIONANDO** — confirmado en juego el 2026-07-01. La civ aparece y es
> seleccionable, con árbol de tecnología, cartas de metrópoli y barajas default.

---

## Instalación

1. Copiar la carpeta del mod a:
   ```
   %USERPROFILE%\Games\Age of Empires 3 DE\<profile_id>\mods\local\minimal-hungary\
   ```
   (debe quedar `mods\local\minimal-hungary\data\...`)
2. Iniciar el juego → **Mods → Local Mods** → habilitar `minimal-hungary`.
3. Reiniciar el juego por completo.
4. Seleccionar **Húngaros / Hungarians** en el selector de civilización.

> ⚠️ Solo debe haber **un** mod de civilización nueva "húngara" habilitado a la vez.
> Si `localmod2` (el mod EEX, que agrega `EEXHungary`) está activo simultáneamente,
> puede haber colisión de nombre visible. Ver [Solución de problemas](#solución-de-problemas).

---

## Estructura de archivos

```
mod-minimal/
  README.md                                    ← este archivo
  data/
    civmods.xml                                ← registro de la civilización (aditivo sobre civs.xml)
    techtreemods.xml                           ← 7 techs de edad propios (aditivo sobre techtreey.xml)
    protomods.xml                              ← unidades/edificios propios (aditivo sobre protoy.xml)
    homecityhungarymin.xml                     ← metrópoli completa (211 cartas, 6 barajas)
    uitechtree/
      techtreedata_hunhungarians.xml           ← layout del árbol de tecnología (UI)
    wpfg/resources/images/icons/hungary/
      honved.png                               ← retrato del Honvéd (portraiticon; 64×64, marco completo)
      honved64.png                             ← icono del botón del cuartel (64×64, con marco UI)
    strings/
      english/stringmods.xml                   ← nombres en inglés
      spanish/stringmods.xml                   ← nombres en español
    tactics/                                    ← tactics propias (posturas Hajduk, montar/desmontar)
  sound/                                        ← ¡HERMANO de data/, NO dentro! sonidos por unidad
    hunhajduk_snds.xml, hunhonved_snds.xml, …   ← un _snds.xml por proto nuevo (si no, unidad muda)
```

> **Sonidos**: el juego enlaza el sonido por **nombre de proto** →
> `Sound/<nombreproto-minúsculas>_snds.xml`. Un proto nuevo sin ese archivo queda **mudo**.
> Los `_snds.xml` van en `sound/` en la **raíz del mod** (hermano de `data/`), replicando la
> estructura del juego. Ver `docs/modding-reference.md` § Sonidos de unidad.

> **Iconos personalizados**: los PNG propios van bajo `data/wpfg/resources/images/icons/…`
> y se referencian en el proto sin el prefijo `data\wpfg\` (p. ej.
> `<icon>resources\images\icons\hungary\honved.png</icon>`). Es la misma convención que
> usan los mods de referencia (Polonia, Abstract Nations).

Los archivos `*mods.xml` son **aditivos** (`mergeMode`): se fusionan sobre los
datos base del juego sin sobreescribir el archivo completo, por lo que son
compatibles con parches y con otros mods aditivos.

---

## Contenido detallado por archivo

### 1. `data/civmods.xml` — Registro de la civilización

Nodo raíz `<civmods>`, se fusiona sobre `civs.xml`. Define un único `<civ>` con
nombre interno `HUNHungarians`. El bloque completo está copiado 1:1 de la entrada
de `Germans` del juego base, cambiando solo los campos de identidad propia.

**Campos de identidad propios de Hungría:**

| Campo | Valor | Función |
|---|---|---|
| `<name>` | `HUNHungarians` | Identificador interno único |
| `<main>` | `1` | La hace civ principal jugable (aparece en el selector) |
| `<statsid>` | `HM` | ID único de estadísticas |
| `<portrait>` | `objects\flags\hungarian` | Bandera (reutiliza la de `DERevHungary`) |
| `<culture>` | `EasternEurope` | Categoría cultural (igual que Germans) |
| `<displaynameid>` | `88881001` | → string "Húngaros / Hungarians" |
| `<rollovernameid>` | `88881002` | → string del tooltip |
| `<agetech>` × 5 | `HUNAge0` … `HUNImperialize` | Techs de edad propios (ver `techtreemods.xml`) |
| `<postindustrialtech>` / `<postimperialtech>` | `HUNPostIndustrial` / `HUNPostImperial` | Techs post-edad propios |
| `<homecityfilename>` | `homecityhungarymin.xml` | Referencia a la metrópoli |
| Campos WPF de bandera | `homecityflagiconwpf`, `homecityflagbuttonwpf`, `postgameflagtexture`, `postgameflagiconwpf` | **Críticos** — el selector WPF los necesita para renderizar la civ (assets de `DERevHungary`) |
| `homecityflagbuttonset` / `...large` | `germanFlagBtn` / `germanFlagBtnLarge` | Botón de bandera (reutiliza el alemán; Hungría no tiene botón propio en `buttonsets.xml`) |
| `homecitypreviewwpf` | `h_pc_germans.png` | Preview (reutiliza el alemán) |
| `matchmakingtextures` | (copiado de Germans) | Texturas de matchmaking |

**Campos copiados 1:1 de Germans** (sin cambios): `alliedid`/`alliedotherid`/
`unalliedid`, `deathmatchtech`/`treatytech`/`empirewarstech`, `buildingefficiency`/
`freebuildingefficiency`, todos los `empirewars*`, `startingunit`,
`townstartingunit` (×8), `randomstartingunits`, `unitregen`, y todos los
`multipleblocktrain`.

### 2. `data/techtreemods.xml` — Árbol de tecnología (identidad propia)

Nodo raíz `<techtreemods>`, se fusiona sobre `techtreey.xml`. Define **7 techs
"envoltorio"** propios (IDs `88881101`–`88881107`) que dan a Hungría un tech-tree
con identidad propia. Cada uno simplemente **activa** (`TechStatus active`) el tech
real de Germans correspondiente — un patrón de delegación que evita transcribir
miles de líneas de efectos:

| Tech propio | dbid | Delega en (Germans) |
|---|---|---|
| `HUNAge0` | 88881101 | `Age0German` |
| `HUNColonialize` | 88881102 | `ColonializeGerman` |
| `HUNFortressize` | 88881103 | `FortressizeGerman` |
| `HUNIndustrialize` | 88881104 | `IndustrializeGerman` |
| `HUNImperialize` | 88881105 | `ImperializeGerman` |
| `HUNPostIndustrial` | 88881106 | `PostIndustrialGerman` |
| `HUNPostImperial` | 88881107 | `PostImperialGerman` |

Así, todos los edificios, unidades estándar, políticos y upgrades vienen de los
techs de Germans ya validados por el juego base, pero la civ tiene sus propios
identificadores de tech-tree (no comparte literalmente los nombres de Germans).

**`HUNAge0` además aplica los cambios de gameplay civ-específicos** (ver Cambio 1
abajo), que solo afectan a Hungría porque el Age0 tech solo lo corre el jugador
húngaro:
- Deshabilita `Settler` (`Enable` con `amount=0`, `relativity="Assign"`).
- Habilita `HUNSettlerWagon`.
- Fija el `BuildLimit` de `FishingBoat` en 50 (`relativity="Assign"`).

### 2b. `data/protomods.xml` — Unidades y edificios propios

Nodo raíz `<protomods>`, se fusiona sobre `protoy.xml`. Contiene:

- **`HUNSettlerWagon`** (id/dbid `88881201`): copia exacta del proto base
  `SettlerWagon` (mismas tactics, gather rates, `unittype`s y lista de edificios
  construibles), con `<buildlimit>50</buildlimit>` (el base es 20). Es un proto
  **propio de Hungría** para no afectar a Alemania, que sigue usando el
  `SettlerWagon` base. Cuesta 100 alimento + 100 madera (igual que el base) y es
  `populationcount=2` (cada carretón vale por 2 colonos). Reutiliza los strings del
  `SettlerWagon` base, así que se muestra como "Settler Wagon / Carretón de colonos".
- **`TownCenter`** (`mergeMode='modify'`): se le agrega el botón de train de
  `HUNSettlerWagon` en el slot del colono (page 0, col 0). El cambio al train list
  es global, pero el botón **solo aparece para quien tenga `HUNSettlerWagon`
  habilitado** — es decir, solo Hungría (vía `HUNAge0`). Alemania y las demás civs
  no lo ven.

#### Cambio 1 (2026-07-01): "Colonos → Carretones de colonos"

Diseño económico propio de Hungría, sin unidades ni assets nuevos:

| Regla | Implementación |
|---|---|
| El Town Center crea carretones de colonos (no colonos) | `Settler` deshabilitado + `HUNSettlerWagon` habilitado en `HUNAge0`; botón en el TC vía `protomods.xml` |
| Coste 100 alimento + 100 madera | Ya es el coste base del `SettlerWagon` (heredado) |
| Máximo 50 carretones | `<buildlimit>50</buildlimit>` en el proto `HUNSettlerWagon` |
| No limitan la construcción de barcos; máx. 50 barcos pesqueros | `FishingBoat` `BuildLimit=50` civ-específico en `HUNAge0` (cap independiente del de carretones) |
| Unidades iniciales coherentes | `townstartingunit` / `empirewarsstartingunit` cambiados de `SettlerWagon` a `HUNSettlerWagon` en `civmods.xml` |

#### Cambio 2 (2026-07-01): "El cuartel produce solo mosqueteros y hajduks"

Roster de infantería propio de Hungría. El cuartel muestra **solo** dos unidades:
el **Honvéd** (mosquetero) y el **Hajduk**. En `HUNAge0` se deshabilita la
infantería alemana que activaba `Age0German` (`Crossbowman`, `Skirmisher`,
`Pikeman`, `Dopplesoldner`) y se habilitan `HUNHonved` + `HUNHajduk`, ambos con su
botón agregado al `Barracks` en `protomods.xml`.

#### Cambio 3 (2026-07-01): Honvéd (fusilero de aguja) y Hajduk (con stats del mercenario)

**Honvéd** (`HUNHonved`, id/dbid 88881203) — el "mosquetero" de Hungría:

| Regla | Implementación |
|---|---|
| Stats de mosquetero | Copia **exacta** del proto `Musketeer` base (todas sus stats/multiplicadores) |
| Modelo "camisa roja" | Redshirt / Garibaldini (`deColonialMilitia`): `animfile` → `units\infantry_ranged\colonial_militia\redshirt.xml` (animfile de **mosquetero**, acorde al rol; unidad que en el juego base solo aparece en el editor) |
| Icono del botón del cuartel | `honved64.png` (64×64, **con marco UI**) → `<icon>` |
| Retrato (al seleccionar) | `honved.png` (64×64, marco completo) → `<portraiticon>` |
| Nombre "Honvéd" | Strings `88881013`–`88881015` |

**Hajduk** (`HUNHajduk`, id/dbid 88881202) — copia del Hajduk mercenario del juego
base (`deSaloonHajduk`) con **todas** sus stats (modelo `units\spc\outlaws\hajduk.xml`,
iconos de revolución, 110 HP, carga cuerpo a cuerpo, y todos los `damagebonus` vs
infantería pesada / skirmisher / caballería), **excepto**:

| Excepción pedida | Implementación |
|---|---|
| No debe ser unidad mercenaria/outlaw | Se eliminan los `unittype` `AbstractOutlaw`, `LogicalTypePickableOutlaw`, `LogicalTypePickableMercOutlaw` |
| Coste 60 alimento + 60 oro (original: 110 oro) | `<cost>` Food 60 + Gold 60 |
| Coste 1 de población (original: 3) | `<populationcount>1</populationcount>` |
| No se beneficia por ascenso (ni muestra la UI de ascenso) | Se eliminan el bloque `<veterancybonus>` (bonus de stats por rango) **y** el `<flag>ExperienceUnit</flag>` (el que hace acumular XP / ascender y mostrar la UI). Ambos se recuperarán a futuro con una carta |

> **Nota de arte**: el juego de referencia (`AoE3Reference`) solo contiene datos XML,
> no los assets 3D, así que el modelo 3D se elige entre los `animfile` existentes. Se
> usa el de la "camisa roja" (Redshirt/Garibaldini = `deColonialMilitia`), un animfile
> de mosquetero acorde al rol del Honvéd. Las **imágenes** de la unidad sí son propias:
> `honved64.png` (con marco) para el botón del cuartel y `honved.png` (sin marco) para
> el retrato grande. Para otro modelo 3D basta cambiar el `<animfile>` del proto.

#### Cambio 4 (2026-07-02): Mejoras de cuartel propias + orden + limpieza

**Orden del cuartel**: Honvéd primero (`train` col 0), Hajduk segundo (col 1).

**Mejoras alemanas quitadas**: las mejoras del cuartel que traía `Age0German`
(Veteran/Guard/Imperial de Crossbowman, Skirmisher, Pikeman, Dopplesoldner + Needle
Gun — p. ej. "Ballesteros veteranos") ya no corresponden a ninguna unidad húngara.
Se marcan **`unobtainable` en `HUNAge0`** (14 techs) → desaparecen del cuartel de
Hungría (sin afectar a Alemania).

**6 mejoras propias** (2 ramas × 3 niveles), en `techtreemods.xml`, con botón en el
`Barracks` (página 1) y en el diagrama del árbol de tecnología:

| Rama | Niveles (tech) | Efecto por nivel |
|---|---|---|
| Honvéd | `HUNVeteranHonved` → `HUNGuardHonved` → `HUNImperialHonved` | +20% / +20% / **+50%** vida y ataque; **+0.10** velocidad en los tres |
| Hajduk | `HUNVeteranHajduk` → `HUNGuardHajduk` → `HUNImperialHajduk` | idem |

- Efectos: `Hitpoints` y `Damage allactions` en `BasePercent` (acumulativo sobre la
  base); `MaximumVelocity` en `Absolute` (+0.10 plano).
- **Renombrado**: cada nivel aplica `SetName` a la unidad → pasa a llamarse
  "Honvéd/Hajduk Veterano" → "de la Guardia" → "Imperial" (ya no queda a secas).
- Gating (prereqs de edad): Veterano→`Fortressize` (III edad); Guardia→`Industrialize`
  (IV) + Veterano; Imperial→`Imperialize` (V) + Guardia (progresión acumulativa).
- **Visible pero bloqueada**: se usan los marcadores de edad **genéricos**
  (`Fortressize`/`Industrialize`/`Imperialize`), no los alemanes — el juego los
  reconoce como "requisito de edad" y muestra la mejora en gris/bloqueada antes de la
  edad (igual que las mejoras base). Las 3 comparten slot, así que se ve solo la
  siguiente de la cadena. Hungría activa esos genéricos vía la cadena alemana.
- Nombres estilo estándar del juego (Veterano / de la Guardia / Imperial), strings
  `88881020`–`88881025` (+ rollovers `88881030`–`88881035`).

#### Cambio 6 (2026-07-02): Caballería propia (Establo)

Se quita la caballería alemana (`Uhlan`, `WarWagon` + sus mejoras) para Hungría
(`unobtainable`/disable en `HUNAge0`) y el Establo entrena dos unidades propias:

| Unidad | Base reutilizada | Pop | Notas |
|---|---|---|---|
| **Húsar Magiar** (`HUNMagyarHussar`) | `deLegionMagyarHussar` (modelo/stats/audio) | 3 | Copia directa, solo cambia id/strings |
| **Crabat** (`HUNCrabat`) | `deSaloonCrabat` (mercenario) | 2 | **No** mercenario (quitados tags outlaw), **sin ascensos** (sin `veterancybonus` ni `ExperienceUnit`), multiplicadores nuevos |

Multiplicadores del Crabat: cuerpo a cuerpo **x3 vs Infantería**; a distancia **x3 vs
Caballería** y **x2 vs Artillería**.

Mejoras de caballería (2 niveles, **nada en III**): Guardia en **IV** (+20% vida y
ataque), Imperial en **V** (+50%). Mismo patrón que las de infantería (prereqs de edad
genéricos → visible/bloqueada; `SetName` renombra la unidad). Sin cambio de velocidad.
`HUNGuard/ImperialMagyarHussar` y `HUNGuard/ImperialCrabat` (dbids 88881307–88881310),
strings 88881040–88881063.

> "Defensa" se interpretó como **vida (HP)** (como en infantería). Si se prefería
> armadura, es un cambio menor en el efecto de las techs.

### 3. `data/homecityhungarymin.xml` — Metrópoli (Home City)

Nodo raíz `<homecity>` (archivo completo, **no** aditivo). Copia exacta de
`homecitygerman.xml` del juego base, cambiando solo `<civ>` (→ `HUNHungarians`),
`<name>` (→ Budapest) y `<heroname>` (→ El Caudillo Magiar).

Contiene:
- **211 cartas** (`<cards>`) — el pool completo de envíos de metrópoli de Germans.
- **6 barajas** (`<decks>`): 5 predefinidas (Beginner, Land, Naval, Tycoon, Treaty…)
  + la baraja **`Beginner` marcada como `<default>`**.
- Barajas de revolución (`<revoltdeck>`) heredadas de Germans.
- Todos los campos visuales/de ambiente: `visual`, `watervisual`, `camera`,
  `ambientsounds`, `xsai`, `coffers`, `transportroundtriptime`, etc.

### 4. `data/uitechtree/techtreedata_hunhungarians.xml` — Layout del árbol de tecnología

Copia exacta de `techtreedata_germans.xml`. Define la disposición visual (grupos,
filas, columnas, iconos) del árbol de tecnología que se ve al abrir **"Árbol de
Tecnología"** desde la Ciudad Natal. El nombre de archivo sigue el patrón
obligatorio `techtreedata_<nombre de civ en minúsculas>.xml`.

### 5. `data/strings/english/stringmods.xml` y `.../spanish/stringmods.xml`

Nodo raíz `<stringmods>` (no soporta `mergeMode`; los IDs se añaden al pool global).
Definen los mismos 4 strings en cada idioma:

| ID | Inglés | Español |
|---|---|---|
| `88881001` | Hungarians | Húngaros |
| `88881002` | *(tooltip)* | *(tooltip)* |
| `88881003` | Budapest | Budapest |
| `88881004` | The Magyar Chieftain | El Caudillo Magiar |

> **Importante:** el juego solo carga la carpeta de idioma que coincide con su
> locale activo. Hay que tener el `stringmods.xml` del idioma en que corre el
> juego (aquí: español) o los nombres de la civ no resolverán a ningún texto.

---

## Rango de IDs

| Rango | Uso |
|---|---|
| `88881001`–`88881004` | Strings (nombre, tooltip, ciudad, héroe) |
| `88881010`–`88881015` | Strings de unidades (Hajduk, Honvéd) |
| `88881020`–`88881035` | Strings de mejoras de cuartel (nombres + rollovers) |
| `88881101`–`88881107` | dbids de los 7 techs de edad propios |
| `88881201`–`88881203` | ids/dbids de protos propios (`HUNSettlerWagon`, `HUNHajduk`, `HUNHonved`) |
| `88881301`–`88881306` | dbids de las 6 mejoras de cuartel |
| `HM` | statsid |

Elegido para no colisionar con el mod EEX (`77181xxx`) ni con el mod de Polonia
(`77092xxx`).

---

## Lo que este mod **NO** incluye (el resto se hereda de Germans)

Hungría partió como clon de Germans y ya tiene algunos elementos propios
(`HUNSettlerWagon`, `HUNHajduk`, roster de cuartel propio). Lo que **todavía** no
tiene contenido propio:

- ⚠️ Unidades propias: solo `HUNSettlerWagon` (carretón), `HUNHonved` y `HUNHajduk`
  (cuartel). La caballería (Establo), artillería, etc. siguen siendo las alemanas.
- ❌ Explorador propio (usa el `Explorer` estándar)
- ❌ Políticos propios (usa los de Germans)
- ❌ Bonos de civilización propios
- ❌ Cartas de metrópoli propias (usa el pool alemán completo)
- ❌ IA por civilización (`personalitiesmods.xml`) — un bot no puede jugar como
  Hungría; solo un jugador humano puede seleccionarla
- ❌ Revoluciones propias
- ❌ Visuales de metrópoli propios (usa Berlín/alemán)

Estos son los siguientes pasos si se quiere convertir el esqueleto en una civ con
identidad propia. Ver `docs/architecture.md` en la raíz del proyecto.

---

## Solución de problemas

Basado en la investigación de esta sesión (ver `docs/mre-hungary-report.md` para el
historial completo de los 5+ bugs corregidos hasta llegar a esta versión funcional):

| Síntoma | Causa | Solución |
|---|---|---|
| La civ no aparece en el selector de Escaramuza | `agetech` con nombre inexistente (ej. `ColonizeGerman` en vez de `ColonializeGerman`) | Verificar que todos los `<tech>` existan en `techtreey.xml` |
| No aparece, sin errores en el log | Faltan campos WPF de bandera en `civmods.xml` | Agregar `homecityflagiconwpf`, `homecityflagbuttonwpf`, `homecityflagbuttonset`(+`large`), etc. |
| No aparece en juego en español | Falta `strings/spanish/stringmods.xml` | Crear el `stringmods.xml` del idioma activo del juego |
| Funciona en el editor de escenarios pero no en Escaramuza | Caché obsoleta en `Savegame\sp_HUNHungarians_homecity.xml` / `-v11.dat` de una versión rota anterior | Borrar esos archivos de la carpeta `Savegame` del perfil para forzar regeneración |
| Nombre duplicado / conflicto | Otro mod (ej. `localmod2`/EEX) con una civ húngara activo a la vez | Habilitar solo un mod de civ húngara a la vez |

### Herramienta de depuración

Para inspeccionar los datos fusionados, agregar `DebugOutputGameData` al archivo
`<profile>\Startup\user.cfg` y lanzar el juego. El motor escribe los datos
fusionados en `%TEMP%\Age of Empires 3 DE\Data\data\`, donde se puede verificar que
`civs.xml`, `homecityhungarymin.xml`, etc. contienen la entrada de la civ correcta.

---

## Referencias en el repositorio

- `docs/mre-hungary-report.md` — historial completo de la depuración (bugs 1–5 +
  caché/colisión).
- `docs/modding-reference.md` — referencia técnica y tabla de "Trampas Comunes".
- `docs/additive-data-mods.md` — cómo funciona el sistema de mods aditivos.
- `example/109541_just poland` y `example/312759_abstract nations plus` — mods de
  civs nuevas reales usados como referencia para el patrón de bloque completo.
