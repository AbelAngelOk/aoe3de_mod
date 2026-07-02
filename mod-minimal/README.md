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
    homecityhungarymin.xml                     ← metrópoli completa (211 cartas, 6 barajas)
    uitechtree/
      techtreedata_hunhungarians.xml           ← layout del árbol de tecnología (UI)
    strings/
      english/stringmods.xml                   ← nombres en inglés
      spanish/stringmods.xml                   ← nombres en español
```

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
| `88881101`–`88881107` | dbids de los 7 techs de edad propios |
| `HM` | statsid |

Elegido para no colisionar con el mod EEX (`77181xxx`) ni con el mod de Polonia
(`77092xxx`).

---

## Lo que este mod **NO** incluye (todo se hereda de Germans)

Al ser un clon de Germans, Hungría **no** tiene todavía contenido propio:

- ❌ Unidades únicas (usa Uhlan, Doppelsöldner, War Wagon, etc. alemanes)
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
