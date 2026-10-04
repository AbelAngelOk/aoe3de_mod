# Esquema real del `animfile` (glosario de tags)

Basado en la inspección directa de un `animfile` real extraído del juego
(`ArtUnits.bar` → `units\infantry_ranged\musketeer\musketeer.xml`, con
`musketeer_hats.xml`, `musketeer_guns.xml` y varios `.material` como apoyo — todos
disponibles en `AoE3Reference/Art/units/infantry_ranged/musketeer/` en este repo).
Complementa `docs/unit-models.md` (que explica el concepto general de `<animfile>`/
`<icon>`/`<tactics>` a nivel de proto) — esto documenta el **contenido interno** del propio
archivo `animfile`.

**Importante sobre alcance**: este glosario dice CÓMO ESTÁ ARMADO el sistema y qué controla
cada tag — no es garantía de que se pueda escribir un `animfile` 100% nuevo y funcional desde
cero. La malla/esqueleto/animaciones en sí (`.gr2`) son binario compilado (formato Granny3D,
confirmado por la cabecera `E5 9B 49 5E 6F 63 1F 14...`, la firma estándar del SDK Granny
usada por RAD Game Tools) — un `animfile` sin `.gr2` reales detrás no tiene qué mostrar. Lo
que SÍ es 100% viable sin arte nueva: **recombinar** `.gr2`/`.material` existentes del juego
en un `animfile` propio (mismo patrón que ya usa este mod para clonar protos).

## Archivos que aparecen junto a un `animfile` (por extensión)

| Extensión | Qué es | ¿Se edita? |
|---|---|---|
| `.xml` | El `animfile` en sí — texto plano, editable | **Sí**, es lo único que se edita a mano |
| `.material` | Definición de texturas/shader de UN mesh — texto plano | Sí, si se quiere retexturizar sin cambiar malla |
| `.gr2` | Malla/esqueleto/animación compilados (formato Granny3D binario) | No — requiere pipeline de arte 3D completo (Blender/3ds Max + exportador compatible), fuera del alcance de un mod de datos aditivo |
| `.xml.precomp` | Caché precompilada del `.xml` (cabecera `SX`, texto tokenizado en UTF-16) | No — el juego la regenera sola a partir del `.xml`; no se toca |
| `.xml.XMB` / `.material.XMB` | Caché comprimida del `.xml`/`.material` (cabecera `alz4` = LZ4) | No — mismo caso, autogenerada |

## Estructura raíz

```xml
<animfile>
  <definebone>...</definebone>*     <!-- huesos que este animfile va a usar para adjuntar cosas -->
  <attachment>...</attachment>*     <!-- puntos de "equipo" nombrados (arma, sombrero, mochila...) -->
  <component>ModelComp ...</component>   <!-- EL modelo principal -->
  <anim>NombreAccion ...</anim>*    <!-- una entrada por cada acción animada -->
</animfile>
```

Un `animfile` puede ser el "principal" de una unidad (el que pone `<animfile>` en el proto)
o un archivo **incluido** por otro vía `<include>` (ver `<attachment>` abajo) — en ese caso
suele ser mucho más chico, con un único `<component>` y un solo `<anim>Idle>`
(`musketeer_hats.xml`/`musketeer_guns.xml` son así: solo definen su propio modelo, la unidad
que los incluye se encarga de todas las animaciones de combate).

## `<definebone>`

```xml
<definebone>bone_hat</definebone>
<definebone>bone_gun</definebone>
<definebone>bone_sword</definebone>
<definebone>bone_backpack</definebone>
```

Lista de nombres de hueso del esqueleto que este `animfile` va a necesitar para anclar
attachments (`frombone`/`tobone` más abajo). Son nombres definidos en el `.gr2` del
esqueleto base — no se inventan, tienen que existir en la malla real.

## `<attachment>`

Define un "slot" con nombre (`gun`, `hats`, `sword`, `torch`, `backpack`, `measure tape`,
`saw`, `hammer` en el Mosquetero) que después se puede "poner" sobre el modelo principal con
`<attach>` dentro de un `<anim>` o de otro `<component>`. Dos formas:

**A. Delegar a otro archivo** (lo más común para equipo con su propia lógica de variantes):
```xml
<attachment>gun<include>units\infantry_ranged\musketeer\musketeer_guns.xml</include></attachment>
<attachment>hats<include>units\infantry_ranged\musketeer\musketeer_hats.xml</include></attachment>
```

**B. Definir inline** (para algo simple, un solo modelo sin variantes por tech):
```xml
<attachment>saw<component>saw_villager<assetreference type="GrannyModel">
  <file>units\attachments\saw_villager</file>
</assetreference></component><anim>Idle<component>saw_villager</component></anim></attachment>
```

## `<component>` — el modelo (y su selección de variante)

El nombre `ModelComp` es el componente "principal" de la unidad (el que targetea `UpdateVisual`
en las techs — ver `docs/unit-models.md`). Cualquier otro nombre (`hats`, `guns`, `backpack`)
es un componente de un `<attachment>`.

Dentro de un `<component>`, un `<logic type="Tech">` es la selección de variante **por tech
activa en el jugador**:

```xml
<component>ModelComp
  <logic type="Tech">
    <none>                                          <!-- rama por defecto -->
      <logic type="Tech">
        <none>
          <assetreference type="GrannyModel"><file>units\infantry_ranged\musketeer\musketeer_2age</file></assetreference>
          <attach a="hats" frombone="bone_hat" tobone="HEAD" syncanims="0"></attach>
        </none>
        <churchthinredline>                         <!-- rama si la tech "ChurchThinRedLine" está activa -->
          <assetreference type="GrannyModel"><file>units\infantry_ranged\musketeer\redcoats_age2</file></assetreference>
        </churchthinredline>
      </logic>
    </none>
    <veteranmusketeers>                              <!-- rama si "VeteranMusketeers" está activa -->
      <assetreference type="GrannyModel"><file>units\infantry_ranged\musketeer\musketeer_3age</file></assetreference>
    </veteranmusketeers>
    <guardmusketeers>...</guardmusketeers>
    <age0dutch>                                      <!-- rama si "Age0Dutch" está activa -->
      <assetreference type="GrannyModel"><file>units\infantry_ranged\musketeer\blue_guard</file></assetreference>
    </age0dutch>
    ...
  </logic>
  <decal>...</decal>
</component>
```

**Puntos clave, verificados directo del archivo real:**

- **La clave de cada rama es el nombre de una tech, en minúsculas, sin espacios.** `age0dutch` =
  `Age0Dutch`, `veteranmusketeers` = `VeteranMusketeers`, `derevolutioncolombia` =
  `DERevolutionColombia`. Esto confirma en el propio dato el mecanismo `UpdateVisual` descrito
  en `docs/unit-models.md`: activar esa tech (`TechStatus active`) es lo que hace que el motor
  reevalúe este `<logic>` y elija esa rama.
- **`<logic type="Tech">` puede anidarse** (rama `<none>` que a su vez tiene su propio
  `<logic type="Tech">` adentro) — así maneja combinaciones tipo "si no hay mejora de
  veterano pero SÍ está `ChurchThinRedLine`, usar este otro modelo".
- **Solo importa si la tech está `active` para el jugador**, no si está "obtenida" en el
  sentido de investigable — el motor no distingue entre una tech de mejora normal y una tech
  `Shadow` interna, ambas cuentan igual acá.
- `<assetreference type="GrannyModel"><file>RUTA_SIN_EXTENSION</file></assetreference>` — la
  ruta NO lleva `.gr2`, el motor lo agrega solo. Es relativa a la raíz del árbol de `Art`
  (mismo estilo que `<animfile>` en el proto).
- `<attach a="hats" frombone="bone_hat" tobone="HEAD" syncanims="0">` — pega el attachment
  nombrado `hats` (definido más arriba) al hueso `HEAD` del modelo principal, usando
  `bone_hat` como punto de referencia del lado del attachment. `syncanims="0"` = el
  attachment no necesita sincronizar sus propias animaciones con las del modelo principal
  (es un objeto rígido pegado a un hueso, no algo que se anima independiente).
- `<materialvariant index="1">` (visto en la rama `rgredcoats`) — usa el MISMO `.gr2` pero
  con la variante de textura #1 definida en su `.material` (ver sección de texturas abajo),
  en vez de la variante 0 (default). Es el mecanismo de "mismo modelo, otro color/textura"
  sin geometría nueva.

## `<decal>`

Dentro de `<component>ModelComp`, define el círculo de selección/sombra falsa que se dibuja
bajo la unidad:
```xml
<decal>
  <effecttype>default</effecttype>
  <texture isfakeshadow="1">shadows_selections\shadow_circle_32x32</texture>
  <selectedtexture>shadows_selections\selection_circle_32x32</selectedtexture>
  <width>1.0</width>
  <height>1.0</height>
</decal>
```

## `<anim>` — animaciones nombradas

```xml
<anim>Volley_standing_attack
  <assetreference type="GrannyAnim">
    <file>animation_library\range\volley\volley_standing_fire</file>
    <tag type="Attack">0.48</tag>
    <tag type="SpecificSoundSet" checkvisible="1" set="MusketShot">0.48</tag>
    <tag type="Particles" particlename="musketshot">0.48</tag>
  </assetreference>
  <component>ModelComp</component>
  <attach a="gun" frombone="bone_gun" tobone="Bip01 Prop1" syncanims="1"></attach>
</anim>
```

- **El nombre** (`Volley_standing_attack`, `Death_by_melee`, `Build`, `Cheer`...) es lo que
  el archivo `.tactics` referencia por nombre para disparar esa animación en respuesta a una
  acción de combate/comportamiento. **Esta es la conexión real entre `tactics` y `animfile`**
  que en `docs/unit-models.md` se documentó como "deben ser compatibles" — ahora se ve
  exactamente por qué: si el `.tactics` pide un nombre de `<anim>` que este `animfile` no
  tiene definido, no hay animación que reproducir.
- **Puede haber varias `<assetreference type="GrannyAnim">` para el mismo nombre** — el motor
  elige una al azar cada vez (ponderado por `<weight>` si está presente; sin `<weight>` se
  reparte parejo). Así se logra variación (3 animaciones de muerte distintas para
  "Death_by_melee", 6 variantes de idle para "NuggetPirate2_Idle", etc.).
- **`<tag>` dentro de un `<assetreference>`** marca un instante dentro de la animación
  (0.0–1.0, fracción de su duración) donde pasa algo:
  - `type="Attack"` — el momento exacto donde se aplica el daño del `<protoaction>` (no al
    empezar la animación, sino cuando el arma "conecta" visualmente).
  - `type="FootstepLeft"`/`"FootstepRight"` con `footprinttype="..."` — sonido de paso y en
    qué pie.
  - `type="SpecificSoundSet" set="MusketShot"` (o `"Build"`, `"BuildSaw"`, `"Swoosh"`,
    `"RagdollImpact"`...) — dispara un soundset puntual del sistema de sonido en ese
    instante (evento, no la voz continua de `Sound/<proto>_snds.xml`).
  - `type="Particles" particlename="musketshot"` — dispara un efecto de partículas.
- **`<component>ModelComp</component>`** dentro del `<anim>` dice a qué componente aplica
  esta animación (casi siempre `ModelComp`, el principal).
- **`<attach>` dentro de un `<anim>`** — mismo mecanismo que dentro de `<component>`, pero
  puede variar por animación (ej. el arma se sostiene distinto durante "Build" que durante
  "Volley_standing_attack").

## `.material` — texturas y variantes

Un `.material` acompaña a un `.gr2` (mismo nombre base) y define, por cada "submaterial"
(zona de la malla con su propio material — `mata`/`matb`/`matc` en el ejemplo, típicamente
cuerpo/cara/equipo por separado):

```xml
<material>
  <submaterial name="mata">
    <materialdef name="default_doublesided_cutout"></materialdef>
    <parameters>                                 <!-- variante 0 (default) -->
      <texture name="BaseColor" override="units\infantry_ranged\musketeer\textures\redcoats_age4_mata_basecolor"></texture>
      <texture name="Normals" override="units\infantry_ranged\musketeer\textures\redcoats_age4_mata_normals"></texture>
      <texture name="Masks" override="units\infantry_ranged\musketeer\textures\redcoats_age4_mata_masks"></texture>
      <texture name="Details" override="units\infantry_ranged\musketeer\textures\redcoats_age4_mata_details"></texture>
      <float name="Lift Metallic" override="0.2500"></float>
      <float name="Roughness Max" override="0.9010"></float>
    </parameters>
    <parameters variant="1">                     <!-- variante 1 (la que pide materialvariant index="1") -->
      <texture name="BaseColor" override="units\infantry_ranged\musketeer\textures\redcoats_age4alt_mata_basecolor"></texture>
      ...
    </parameters>
  </submaterial>
  <submaterial name="matb">...</submaterial>
</material>
```

**Glosario de los 4 slots de textura** (nombres confirmados, son los únicos que aparecen en
los `.material` inspeccionados):

| Slot | Contenido |
|---|---|
| `BaseColor` | El color/albedo — la textura "de color" propiamente dicha |
| `Normals` | Mapa de normales (relieve/detalle de superficie sin geometría extra) |
| `Masks` | Máscaras — típicamente separa metálico/rugosidad/**color de equipo del jugador** por canal |
| `Details` | Textura de detalle adicional (patrones finos, desgaste) |

Los `<float>` (`Lift Metallic`, `Lift Non-Metallic`, `Roughness Max`, `Metallic Max`) son
parámetros del shader PBR (metalness/roughness), ajustan el brillo/metalicidad sin tocar
ninguna textura.

**No hay extensión de archivo en `override="..."`** — son `.dds` (formato estándar de
texturas comprimidas de este tipo de motor), viven en `ArtUnitsTextures1-5.bar` (para
unidades) separados del `.material`/`.gr2` que están en `ArtUnits.bar`. No se extrajeron en
esta sesión — si hace falta ver el contenido real de una textura (no solo su ruta), avisar
para extraer el `.bar` correspondiente.

## Resumen — qué es editable a mano y qué no

| Querés hacer... | ¿Se puede solo editando `.xml`/`.material`? |
|---|---|
| Que una unidad use el modelo de otra unidad real (clon, sin arte nueva) | **Sí** — copiar el `animfile` entero o solo apuntar `<file>` a otro `.gr2` existente |
| Que una unidad cambie de aspecto según una tech propia (ej. reskin narrativo) | **Sí** — agregar una rama nueva al `<logic type="Tech">` con la key en minúsculas del nombre de tu tech, apuntando a un `.gr2` YA EXISTENTE |
| Que una unidad tenga una variante de color/textura nueva reusando la MISMA malla | **Parcial** — si el `.material` original ya define esa variante (`variant="N"`) se puede usar tal cual; si no, hace falta editar/crear el `.material` con una textura nueva, y esa textura sí requiere arte (imagen `.dds`) nueva |
| Un modelo 3D 100% nuevo (geometría que no existe en el juego) | **No** desde este proyecto — requiere pipeline de arte 3D (modelado + rig + animación + exportador a Granny3D), fuera del alcance de edición de datos |

## Ejemplo real completo de referencia

El árbol extraído en este repo (`AoE3Reference/Art/units/infantry_ranged/musketeer/`) sirve
como caso de estudio íntegro: `musketeer.xml` (principal, con las ~10 ramas de `<logic
type="Tech">` para Veterano/Guardia/Imperial/Holanda/varias revoluciones), sus dos
`<attachment>` delegados (`musketeer_guns.xml`, `musketeer_hats.xml`), y varios `.material`
con y sin variantes. Es el ejemplo más rico de los disponibles — vale la pena mirarlo directo
antes de intentar escribir un `animfile` propio, en vez de guiarse solo por este glosario.
