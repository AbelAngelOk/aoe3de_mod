# Cómo funcionan los modelos de unidad en AoE3 DE

Guía de referencia sobre el sistema visual de una unidad/edificio: qué campo controla qué,
qué se puede reusar gratis y qué hay que copiar a mano. Complementa
`docs/modding-reference.md` (que tiene el detalle de sonido, cartas, etc.) — esto se enfoca
solo en la parte visual/modelo. Ejemplos reales tomados de las civs ya hechas en
`mod-minimal/` (Hungría, Finlandia, Argentina, Egipto, Hungría Otomana/Alemana, Holanda
Italiana, Rumania).

## Los tres campos que definen "cómo se ve" una unidad

Un `<unit>` en `protoy.xml` (o en `protomods.xml` para un clon propio) separa el modelo, el
ícono y el comportamiento en tres campos independientes que **no dependen entre sí**:

```xml
<unit id="..." name="MiUnidad">
  <animfile>units\infantry_ranged\musketeer\musketeer.xml</animfile>   <!-- modelo 3D + animaciones -->
  <icon>resources\art\units\infantry_ranged\musketeer\musketeer_icon_64x64.png</icon>       <!-- botón 64x64 -->
  <portraiticon>resources\art\units\infantry_ranged\musketeer\musketeer_portrait.png</portraiticon>  <!-- retrato grande al seleccionar -->
  <minimapicon>ui\minimap\hero</minimapicon>  <!-- opcional, ej. para héroes -->
  <tactics>rifleman.tactics</tactics>          <!-- comportamiento de combate/animación por acción -->
</unit>
```

- **`<animfile>`**: apunta a un `.xml` dentro de `units\...\` que define la malla 3D, texturas
  y el set de animaciones (idle, ataque, muerte, correr, etc.). Es lo único que determina
  "qué modelo se ve en el mapa".
- **`<icon>`** / **`<portraiticon>`**: PNGs planos, sin relación con el modelo 3D. Son
  arte 2D horneado (ver sección de marcos de cartas en `modding-reference.md` para el mismo
  concepto aplicado a cartas). Cambiar el ícono NO cambia el modelo, y viceversa.
- **`<tactics>`**: archivo `.tactics` que define qué animación del `animfile` se dispara para
  cada `<protoaction>` (ataque normal, escalonado, en volea, defensivo...). El `animfile` y el
  `tactics` deben ser **compatibles** — si el tactics pide una animación de postura que el
  animfile no tiene, la unidad puede quedar en T-pose o sin animar (ver tabla de troubleshooting
  al final).

**Ninguno de los tres controla el sonido.** La voz se resuelve aparte, por nombre de proto vía
`Sound/<nombreproto>_snds.xml` — ver `modding-reference.md` § "Sonidos de unidad". Es el error
más común: cambiar/clonar el `animfile` y asumir que la voz "viene con él". No es así.

## La diferencia crítica: assets visuales vs. assets de audio

Esta es la trampa que más tiempo costó en este proyecto (ver memoria `aoe3-unit-sounds-snds`):

| | Assets visuales (`animfile`, `icon`, `portraiticon`) | Assets de audio (`.wav`/`.mp3` de un soundset) |
|---|---|---|
| ¿Resuelven contra los assets base del juego sin copiarlos al mod? | **Sí** — un mod aditivo puede referenciar `units\cavalry\dragoon\dragoon.xml` o cualquier ícono real tal cual, sin tenerlo en su propia carpeta | **No** — el `filename` de un `<sound>` dentro de un `<soundset>` necesita el archivo físicamente presente en la carpeta `sound/` del propio mod |
| Consecuencia práctica | Cualquier civ nueva puede clonar un proto real y apuntar su `<animfile>`/`<icon>` al path original sin copiar nada | Un soundset nuevo que apunte a un `.wav` vanilla por nombre suelto (sin copiarlo) queda **mudo**, confirmado en juego |

Por eso, en este mod, clonar `deSaloonHajduk` → `HUNHajduk` fue tan simple como copiar el
`<animfile>units\spc\outlaws\hajduk.xml</animfile>` tal cual — pero hizo falta crear
`sound/hunhajduk_snds.xml` a mano (ver más abajo) porque el nombre de proto cambió.

## Reusar un modelo real sin clonar el proto

Si una civ nueva simplemente **habilita un proto real** (`Enable=1` vía su tech de Age0), no
hace falta tocar nada visual — el proto ya trae su propio `animfile`/`icon` y se ve
exactamente como en el juego base. Así se maneja la mayoría de las unidades reutilizadas en
este mod: `Ruyter`, `Hussar`, `CavalryArcher` (antes de reemplazarlo), `deArchitect`, `Envoy`,
`HUNCrabat` (reutilizado tal cual por Hungría Otomana/Alemana y por Rumania), etc.

## Clonar un proto para darle una identidad propia

Cuando una civ necesita una unidad con su propio `buildlimit`, costo, nombre o disponibilidad
por edad — pero **sin arte nuevo** — el patrón de este mod es: copiar el bloque `<unit>`
completo del proto real a `protomods.xml`, con un `id`/`dbid`/`name` propios, y **dejar
`<animfile>` intacto** (apunta al mismo modelo real). Solo cambian los campos de identidad:

```xml
<!-- ROUDorobant: clon de xpColonialMilitia (protomods.xml) -->
<unit id="88888206" name="ROUDorobant">
  <dbid>88888206</dbid>
  <displaynameid>88888210</displaynameid>
  <animfile>units\infantry_ranged\colonial_militia\colonial_militia.xml</animfile>  <!-- SIN TOCAR -->
  <icon>resources\art\units\revolution\dorobant_icon.png</icon>   <!-- ícono real de la revolución, reusado -->
  <portraiticon>resources\art\units\revolution\dorobant_portrait.png</portraiticon>
  <initialhitpoints>230.0000</initialhitpoints>  <!-- x1.15 del real, mismo ajuste que aplica la revolución -->
  <allowedage>1</allowedage>  <!-- distinto al real (2), para que esté antes en el Blocao -->
  ...
</unit>
```

Ejemplos de este mismo patrón en el mod: `HUNGrenzer` (clon de `deNMPandour`), `HUNPandur`
(clon de `deMercPandour`), `ITDBersagliere` (clon de `deBersagliere`), `ROUWallachianArcher`
(clon de `CavalryArcher`), `ROURoshiorDragoon` (clon de `Dragoon`), `ITDSettlerDutch`/
`ITDSettlerItalian` (clones de `Settler`, mismo `<train>` de construcción embebido incluido).

**Por qué clonar en vez de modificar el proto real directamente**: `CavalryArcher`, `Dragoon`,
`Settler`, etc. son protos **compartidos** por todas las civs del mod (y por cualquier civ real
del juego base que los use). Aplicar `SetName`/`UpdateVisual`/nerfeos directo sobre el proto
real afectaría a TODAS las civs que lo tengan habilitado, no solo a la nueva. Clonar aísla el
cambio a la civ que lo pidió.

## Íconos "dummy": protos que solo existen para prestar un ícono

El juego base tiene decenas de protos mínimos, sin `animfile` ni `tactics` ni stats, que
**solo** definen `<icon>`/`<portraiticon>` — sirven como "banco de íconos" que una tech
copia hacia el proto real vía el efecto `CopyUnitPortraitAndIcon`. Nunca son entrenables ni
utilizables como unidad — son puramente un contenedor de arte.

```xml
<!-- protoy.xml — ejemplos reales -->
<unit id="2640" name="deIconVillagerDutch">
  <dbid>3215</dbid>
  <icon>resources\art\units\villagers\villager_dutch_icon.png</icon>
  <portraiticon>resources\art\units\villagers\villager_dutch_portrait.png</portraiticon>
</unit>

<unit id="1726" name="deIconREVDorobant">
  <dbid>2292</dbid>
  <icon>resources\art\units\revolution\dorobant_icon.png</icon>
  <portraiticon>resources\art\units\revolution\dorobant_portrait.png</portraiticon>
</unit>
```

En el juego real se usan así (`DERevolutionRomania`, la tech de la revolución rusa a Rumania):

```xml
<effect type="Data" amount="0.00" subtype="CopyUnitPortraitAndIcon" unittype="xpColonialMilitia" relativity="Absolute">
  <target type="ProtoUnit">deIconREVDorobant</target>
</effect>
```

Esto copia el ícono/portrait de `deIconREVDorobant` (el dummy) hacia `xpColonialMilitia` (el
proto real que se está reskineando). **En un clon propio, este paso completo no hace falta**:
como el `<icon>`/`<portraiticon>` ya son campos fijos del proto clonado, basta con poner
la ruta del dummy directamente ahí (así se hizo con `ROUDorobant` arriba) — no hay que
replicar el efecto `CopyUnitPortraitAndIcon` en una tech.

**Patrón de nomenclatura de estos dummies** (útil para buscarlos): `deIcon<Contexto><Nombre>`.
Ejemplos reales encontrados en este proyecto:
- `deIconVillagerDutch` — colono holandés (no existe un `deIconVillagerItalian` equivalente).
- `deIconExplorerITCenturion` / `deIconFemaleExplorerITVenetian` — skin "Centurión" del
  Explorador para Italia.
- `deIconExplorerSWThor`, `deIconExplorerSPDelgado`, `deIconExplorerBRDrake`,
  `deIconExplorerFRPecaudy` — skins de héroe de Explorador por civ (Suecia/España/
  Portugal/Francia).
- `deIconREVWallachianHorseArcher`, `deIconREVRosior`, `deIconREVDorobant` — reskins de
  unidades de la revolución rumana.

**No asumir que existe un dummy para cada nacionalidad.** Antes de diseñar una unidad
"con cara propia" para una civ, buscar primero (`grep -i "deIcon.*<Contexto>"` en
`protoy.xml`) si el asset ya existe. Si no existe, no hay forma de fabricarlo sin arte nuevo —
la opción honesta es dejar el ícono genérico del proto base, no inventar una ruta que no
existe en los datos del juego.

## Skins dentro del mismo animfile: `skinlogic` y `UpdateVisual`

Un solo `<animfile>` puede contener **más de una variante visual** (piel/atuendo) del mismo
modelo base, seleccionable por índice. Esto se ve indirectamente en dos mecanismos distintos:

### 1. Selección de skin fija por el jugador (`skinlogic`, visible en el sonido)

El sistema de sonido expone esta selección de skin como `<skinlogic>` con claves `"none"`
(variante por defecto), `"0"`, `"1"`, `"2"`... — por ejemplo, el Explorador puede tener una
variante femenina ("Femplorer") o una variante "héroe" (Thor para Suecia, Delgado para
España, Centurión para Italia). El mismo índice de skin que el jugador elige en el juego
determina tanto qué `<soundset>` suena como qué variante visual del `animfile` se renderiza
— son dos sistemas paralelos (sonido y visual) que comparten la misma clave de skin, pero el
`skinlogic` en sí solo aparece documentado del lado de sonido (`Sound/*_snds.xml`); del lado
visual no hay un campo equivalente expuesto en `protoy.xml` — es interno del `animfile`/motor.

### 2. Cambio de skin disparado por una tech (`UpdateVisual`)

Cuando una unidad "mejora" (Veterano/Guardia/Imperial, o un reskin narrativo como Culebrina →
Espingarda), el cambio de apariencia **no es un modelo nuevo** — es el mismo `animfile` con
otra variante activada. El efecto que dispara esto es `UpdateVisual`:

```xml
<!-- DESpingardes (mejora real que convierte la Culebrina en "Espingarda", solo Italia) -->
<effect type="Data" amount="1.35" subtype="Hitpoints" relativity="BasePercent">
  <target type="ProtoUnit">Culverin</target>
</effect>
<effect type="Data" amount="0.00" subtype="UpdateVisual" unittype="Culverin" relativity="Absolute">
  <target type="Player"></target>
</effect>
<effect type="SetName" proto="Culverin" culture="none" newname="124632"></effect>  <!-- "Espingarda" -->
```

Notar el patrón completo, que se repite en TODAS las mejoras "con cambio de skin" del juego
(`VeteranDragoonsShadow`, `GuardDragoons`, `DEImperialSpingardes`, `GrapeShot`,
`ImperialCulverin`, etc.):

1. Efecto(s) `Data` con `subtype="Hitpoints"`/`"Damage"` (`relativity="BasePercent"`) — el
   stat boost real.
2. `UpdateVisual` con `unittype="<ProtoAfectado>"` sobre `target type="Player"` (**no**
   `type="ProtoUnit"` — el target es el jugador, no la unidad) — esto es lo que dispara el
   cambio visual.
3. `SetName proto="..." newname="..."` — el nombre mostrado cambia junto con el visual.

**Los tres pasos son independientes entre sí.** Se puede aplicar el stat boost sin el
`UpdateVisual` (el visual no cambia, pero las stats sí) o el `SetName` sin ninguno de los
otros dos (cambia el nombre, no las stats ni el visual) — como pasó justamente con
`DESpingardes`: su `SetName` real tiene `reqtech="DEAge0Italians"`, así que solo aplica si esa
tech puntual está activa para el jugador; una civ que dispare el `UpdateVisual`/stats sin
tener `DEAge0Italians` activo vería el modelo/stats de "Espingarda" pero el nombre seguiría
diciendo "Culebrina". (Esto es justo lo que motivó clonar la tech como `ITDSpingardes` en
Holanda Italiana — mismo efecto, pero sin esa condición, para que el nombre cambie siempre.)

**Consecuencia para clones**: si un clon propio (proto nuevo) quiere "heredar" el aspecto de
la skin mejorada de su original, hay que replicar el mismo patrón (`UpdateVisual
unittype="MiCloneName"`) apuntando al NOMBRE DEL CLON, no al proto real — un `UpdateVisual`
que targetea `Dragoon` no hace nada sobre `ROURoshiorDragoon`, son protos distintos aunque
compartan el mismo `animfile` de origen.

## Tabla resumen: qué copiar y qué no, según lo que se quiere lograr

| Objetivo | `animfile` | `icon`/`portraiticon` | Sonido (`_snds.xml`) | Notas |
|---|---|---|---|---|
| Habilitar un proto real tal cual | No tocar | No tocar | No tocar (ya tiene) | Solo `Enable=1` en la tech de Age0 |
| Clonar un proto real con nombre propio (mismo aspecto) | Copiar la ruta del original sin cambios | Copiar la ruta del original (o de un dummy `deIcon...` si existe uno más apropiado) | **Crear `sound/<clonminúsculas>_snds.xml` nuevo**, aunque sea copiando 1:1 el del original | El nombre de proto cambió → el sonido deja de resolver automáticamente |
| Reskin narrativo de un proto COMPARTIDO (ej. Culebrina→Espingarda) | No aplica (no hay clon) | No aplica | Puede necesitar agregar una rama de `<civlogic>` nueva | Usar `UpdateVisual` + `SetName` en una tech propia; ver sección de sonido en `modding-reference.md` sobre por qué esa rama nueva necesita el patrón `MM<Nombre>` + `.wav` copiado a `sound/mm/` |
| Unidad 100% original (arte nueva de verdad) | Fuera del alcance de un mod de datos aditivo — requiere arte 3D nueva empaquetada | Igual | Igual | Este mod nunca lo hizo; todo se resuelve reusando assets reales del juego |

## Troubleshooting

| Síntoma | Causa típica | Fix |
|---|---|---|
| Unidad en T-pose o sin animar | `tactics` pide una animación/postura que el `animfile` no tiene, o se usó un `deIcon...` (stub sin `animfile`) como si fuera una unidad real | Usar el `tactics` del proto de origen del `animfile`, o directamente no tocar `tactics` al clonar |
| Unidad muda pese a tener el modelo correcto | La voz se resuelve por **nombre de proto**, no por `animfile` — un proto nuevo no tiene `_snds.xml` | Crear `sound/<nombreproto>_snds.xml` (ver `modding-reference.md`) |
| El "reskin de mejora" (Veterano/Espingarda/etc.) no cambia el modelo | El `UpdateVisual` no se disparó (falta el efecto, o el `target` no es `type="Player"`), o el `animfile` no tiene esa variante | Revisar que estén los 3 pasos (stats + `UpdateVisual` + `SetName`) en la tech; si el modelo real nunca tuvo esa variante, no hay nada que cambiar del lado de datos |
| El "reskin de mejora" cambia el modelo pero no el nombre (o viceversa) | Los 3 efectos son independientes; puede faltar uno, o tener un `reqtech`/condición que no se cumple para la civ actual | Clonar la tech sin la condición, o agregar el efecto faltante |
| Ícono "inventado" que no existe en el juego | Se asumió que existe un `deIcon<Nacionalidad><Cosa>` sin verificarlo | `grep -i` en `protoy.xml` antes de asumir; si no existe, usar el ícono genérico del proto base |
