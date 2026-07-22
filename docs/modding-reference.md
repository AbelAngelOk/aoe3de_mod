# Referencia Técnica de Modding AoE3DE

Fuentes: documentación oficial de Additive Data Mods (support.ageofempires.com), análisis del mod de referencia `109541_just poland`, y observación directa del comportamiento del motor.

---

## Sistema de Archivos Additive Mods

En el sistema antiguo de modding, el mod tomaba una copia completa de un archivo de datos del juego y la sobreescribía. Esto causaba dos problemas:
- **Incompatibilidad con parches**: cuando el juego se actualiza, el mod queda invalidado y debe rehacerse.
- **Incompatibilidad entre mods**: si dos mods modifican el mismo archivo, no pueden estar activos al mismo tiempo.

Con additive mods, el archivo del mod se **fusiona** con los datos base. Esto significa:
- Los parches del juego no invalidan el mod (la fusión se aplica sobre la nueva versión del archivo base).
- Múltiples mods pueden modificar el mismo archivo base sin conflictos.

### Cómo usar

1. Colocar el archivo additive en la carpeta `Data/` del mod.
2. El nombre del archivo y el nodo raíz XML deben seguir la tabla oficial (ver abajo).
3. Usar el atributo `mergeMode` en cada nodo para controlar cómo se fusiona.

### mergeMode disponibles

- `modify` (default si existe el nodo en los datos base): Fusiona con el nodo base.
- `add` (default si NO existe el nodo en los datos base): Agrega como nuevo elemento.
- `remove`: Elimina el nodo de los datos base.
- `replace`: Reemplaza completamente el nodo base.

> **NOTA**: `stringmods.xml` es la única excepción — **NO soporta mergeMode**. El sistema de strings
> funciona diferente: los IDs que se definen en el mod se añaden al pool global de strings,
> siempre que usen IDs únicos no colisionantes con el juego base ni con otros mods.

### Tabla completa de archivos additive soportados (fuente: documentación oficial)

| Archivo base | Archivo mod | Nodo raíz |
|---|---|---|
| `protoy.xml` | `protomods.xml` | `<protomods>` |
| `techtreey.xml` | `techtreemods.xml` | `<techtreemods>` |
| `civs.xml` | `civmods.xml` | `<civmods>` |
| `politiciandata.xml` | `politicianmods.xml` | `<politicianmods>` |
| `nuggets.xml` | `nuggetmods.xml` | `<nuggetmods>` |
| `protounitcommands.xml` | `protounitcommandmods.xml` | `<protounitcommandmods>` |
| `cultures.xml` | `culturemods.xml` | `<culturemods>` |
| `maptypes.xml` | `maptypemods.xml` | `<maptypemods>` |
| `mapspecifictechs.xml` | `mapspecifictechmods.xml` | `<mapspecifictechmods>` |
| `attacktime.xml` | `attacktimemods.xml` | `<attacktimemods>` |
| `abilities\abilities.xml` | `abilities\abilitymods.xml` | `<abilitymods>` |
| `abilities\powers.xml` | `abilities\powermods.xml` | `<powermods>` |
| `randomnames.xml` | `randomnamemods.xml` | `<randomnamemods>` |
| `strings\<language>\*.xml` | `strings\<language>\stringmods.xml` | `<stringmods>` |
| `economymode.xml` | `economymodemods.xml` | `<economymodemods>` |
| `personalities.xml` | `personalitiesmods.xml` | `<personalitiesmods>` |
| `homecity<civ>.xml` | `homecity<civ>.mods.xml` | `<homecitymods>` |
| `tactics\<type>.tactics` | `tactics\<type>.mods.tactics` | `<tacticsmods>` |
| `uitechtree\techtreedata_<civ>.xml` | `uitechtree\techtreedata_<civ>.mods.xml` | `<uitechtreemods>` |

> **NOTA**: La fila `homecity<civ>.mods.xml` / `<homecitymods>` es para MODIFICAR una home city
> existente. Para civilizaciones nuevas (como EEX), se crea `homecityeex<civ>.xml` con raíz
> `<homecity>` — es un archivo completo nuevo, no un mod additive de uno existente.

### Ejemplos oficiales de mergeMode

**protomods.xml** — los 4 modos:
```xml
<protomods>
    <!-- remove: elimina una unidad del proto -->
    <Unit mergeMode='remove' name='PropsPottedPlants'/>
    <!-- modify (default): agrega un flag a una unidad existente -->
    <Unit name='PropsPoles'>
        <Flag>NotPlayerPlaceable</Flag>
    </Unit>
    <!-- modify con add y remove de Train al mismo tiempo -->
    <Unit name='Manor'>
        <Train row='0' page='1' column='2'>Longbowman</Train>
        <Train mergeMode='remove'>xpColonialMilitia</Train>
    </Unit>
    <!-- replace: reemplaza completamente el nodo -->
    <Unit mergeMode='replace' id="1797" name='deIconUSCowboy'>
        <DBID>2372</DBID>
        <Icon>resources\art\units\spc\outlaws\cowboy_icon2.png</Icon>
        <PortraitIcon>resources\art\units\spc\outlaws\cowboy_portrait2.png</PortraitIcon>
    </Unit>
    <!-- add (default si no existe): agrega una unidad nueva -->
    <Unit name='MyNewProtoUnit'>
        <DBID>2400</DBID>
    </Unit>
</protomods>
```

**techtreemods.xml** — agregar un effect a un tech existente:
```xml
<techtreemods>
    <!-- add effect a un tech existente (enable Pikeman para los Rusos) -->
    <Tech name='Age0Russian'>
        <Effects>
            <Effect mergeMode='add' type='Data' amount='1.00' subtype='Enable' relativity='Absolute'>
                <Target type='ProtoUnit'>Pikeman</Target>
            </Effect>
        </Effects>
    </Tech>
    <!-- modificar un effect: cambiar costo de unidad existente -->
    <Tech name='ypAge0IndiansSpecialTechs'>
        <Effects>
            <Effect mergeMode='remove' type='Data' amount='45.00' subtype='Cost' resource='Food' relativity='Absolute'>
                <Target type='ProtoUnit'>ypSacredCow</Target>
            </Effect>
            <Effect mergeMode='add' type='Data' amount='-70.00' subtype='Cost' resource='Food' relativity='Absolute'>
                <Target type='ProtoUnit'>ypSacredCow</Target>
            </Effect>
        </Effects>
    </Tech>
</techtreemods>
```

**stringmods.xml** — no usa mergeMode:
```xml
<stringmods>
   <StringTable>
      <Language name='English'>
         <String _locID='20038'>ModContinue</String>
      </Language>
   </StringTable>
</stringmods>
```

### Debug: DebugOutputGameData

Para verificar que el mod se fusiona correctamente, agregar `DebugOutputGameData` al archivo
`C:\Users\<user>\Games\Age of Empires 3 DE\<id>\Startup\user.cfg` (crear si no existe).

El motor escribirá todos los datos fusionados en `%TEMP%\Age of Empires 3 DE\Data\`
(ej: `C:\Users\<user>\AppData\Local\Temp\Age of Empires 3 DE\Data\`).

Flujo recomendado:
1. Activar la variable y ejecutar el juego **sin** mods → guardar los archivos base.
2. Activar el mod y ejecutar de nuevo → comparar los archivos para confirmar los cambios.

---

## civmods.xml

Registra una nueva civilización. Los nombres en `<agetech>` deben coincidir EXACTAMENTE
con los nombres definidos en `techtreemods.xml`.

```xml
<civ>
  <name>EEXHungary</name>           <!-- Nombre interno único -->
  <main>1</main>                     <!-- 1 = civ principal jugable -->
  <gameid>EEXpack</gameid>
  <statsid>EEXHUNGARY</statsid>
  <portrait>objects\flags\german</portrait>
  <culture>EasternEurope</culture>
  <settlerprotoname>Settler</settlerprotoname>
  <displaynameid>77181001</displaynameid>
  <rollovernameid>77181002</rollovernameid>

  <startingunit>EEXHungarianExplorer</startingunit>

  <!-- Age techs: los nombres DEBEN coincidir exactamente con techtreemods.xml -->
  <agetech>
    <age>Age0</age>
    <tech>EEXAge0Hungary</tech>
  </agetech>
  <agetech>
    <age>Age1</age>
    <tech>EEXColonializeHungary</tech>
  </agetech>
  <agetech>
    <age>Age2</age>
    <tech>EEXFortressizeHungary</tech>  <!-- NOT EEXFortifyHungary -->
  </agetech>
  <agetech>
    <age>Age3</age>
    <tech>EEXIndustrializeHungary</tech>
  </agetech>
  <agetech>
    <age>Age4</age>
    <tech>EEXImperializeHungary</tech>  <!-- NOT EEXEmpowerHungary -->
  </agetech>

  <homecityfilename>homecityeexhungary.xml</homecityfilename>
  <homecitypreviewwpf>resources/images/icons/history/histories/h_pc_germans.png</homecitypreviewwpf>
  <homecityflagbuttonset>germanFlagBtn</homecityflagbuttonset>
</civ>
```

---

## techtreemods.xml — Age0 Tech (PATRÓN CORRECTO)

El Age0 tech es el más crítico. Si falta cualquier elemento, la civilización no funciona.
Basado en el análisis directo de `STARKAge0Polish` del mod de referencia.

**Reglas del Age0 tech:**
1. Debe habilitar (`Enable`) TownCenter, HouseEast, Sheep y TODOS los edificios/unidades estándar europeos
2. Debe activar (`active`) XPTrickle, AAStandardStartingTechs, DEEuropeanStandardTechs, Levy
3. Debe hacer `obtainable` TODOS los políticos de TODAS las edades (Colonial + Fortress + Industrial + Imperial)
4. Debe hacer `obtainable` TODOS los techs de mejora de unidades (Veteran/Guard/Imperial)
5. Los techs de mejora que son `obtainable` desde Age0 aparecen en la UI pero sus `prereqtech` controlan cuándo se pueden investigar

```xml
<tech name="EEXAge0Hungary" type="Normal">
  <dbid>77194001</dbid>
  <status>UNOBTAINABLE</status>
  <flag>Shadow</flag>
  <effects>
    <!-- Explorer propio de la civ -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">EEXHungarianExplorer</target>
    </effect>
    <!-- Edificios estándar europeos — TODOS requeridos -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">TownCenter</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">HouseEast</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Sheep</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Capitol</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">ArtilleryDepot</target>   <!-- NO "Artillery Foundry" -->
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Barracks</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Stable</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Plantation</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">TradingPost</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Market</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Arsenal</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Outpost</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Dock</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">CWallGate</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">WallStraight2</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">WallStraight5</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">WallConnector</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">deTavern</target>
    </effect>
    <!-- Unidades estándar -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Settler</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Priest</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">FieldHospital</target>
    </effect>
    <!-- Artillería -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Falconet</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Culverin</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Mortar</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">xpHorseArtillery</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">xpPetard</target>
    </effect>
    <!-- Barcos -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">FishingBoat</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Caravel</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Galleon</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Frigate</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">Monitor</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">xpSpy</target>
    </effect>
    <!-- Unidades propias de Discovery -->
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">EEXHajduk</target>
    </effect>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">EEXMagyarHussar</target>
    </effect>
    <!-- Techs de sistema — OBLIGATORIOS -->
    <effect type="TechStatus" status="active">XPTrickle</effect>
    <effect type="TechStatus" status="active">AAStandardStartingTechs</effect>
    <effect type="TechStatus" status="active">DEEuropeanStandardTechs</effect>
    <effect type="TechStatus" status="active">Levy</effect>
    <!-- Techs imperiales estándar obtenibles -->
    <effect type="TechStatus" status="obtainable">ImperialCannon</effect>
    <effect type="TechStatus" status="obtainable">ImperialFieldGun</effect>
    <effect type="TechStatus" status="obtainable">FieldGun</effect>
    <effect type="TechStatus" status="obtainable">Bayonet</effect>
    <effect type="TechStatus" status="obtainable">ImperialManOWar</effect>
    <effect type="TechStatus" status="obtainable">ImperialMonitors</effect>
    <effect type="TechStatus" status="obtainable">ImperialHorseArtillery</effect>
    <effect type="TechStatus" status="obtainable">HeavyHorseArtillery</effect>
    <!-- Techs de revolución -->
    <effect type="TechStatus" status="obtainable">DERevolutionHungaryGerman</effect>
    <!-- ... otros techs de revolución relevantes ... -->
    <!-- TODOS los políticos de TODAS las edades — obtenibles desde Age0 -->
    <!-- El motor filtra qué políticos mostrar según la edad actual -->
    <effect type="TechStatus" status="obtainable">EEXPoliticianHungaryColonial1</effect>
    <effect type="TechStatus" status="obtainable">EEXPoliticianHungaryColonial2</effect>
    <effect type="TechStatus" status="obtainable">EEXPoliticianHungaryColonial3</effect>
    <effect type="TechStatus" status="obtainable">EEXPoliticianHungaryFortress1</effect>
    <!-- ... Fortress, Industrial, Imperial ... -->
    <!-- TODOS los upgrades de unidades obtenibles desde Age0 -->
    <effect type="TechStatus" status="obtainable">EEXVeteranHajduk</effect>
    <effect type="TechStatus" status="obtainable">EEXGuardHajduk</effect>
    <effect type="TechStatus" status="obtainable">EEXImperialHajduk</effect>
    <!-- ... resto de upgrades ... -->
  </effects>
</tech>
```

### Age shadow techs (Colonial/Fortress/Industrial/Imperial)

Los shadow techs de edad son simples marcadores activados por el político elegido.
**NO** deben intentar activar `ColonizeShadow`, `FortifyShadow` etc. (esos nombres no existen en el juego base).
**NO** deben hacer `obtainable` nuevos políticos — eso ya se hizo en Age0.

```xml
<!-- Colonial: solo habilita unidades de esa edad -->
<tech name="EEXColonializeHungary" type="Normal">
  <dbid>77194002</dbid>
  <status>UNOBTAINABLE</status>
  <flag>Shadow</flag>
  <prereqtech>EEXAge0Hungary</prereqtech>
  <effects>
    <effect type="Data" amount="1.00" subtype="Enable" relativity="Absolute">
      <target type="ProtoUnit">EEXPandur</target>
    </effect>
  </effects>
</tech>

<!-- Fortress, Industrial, Imperial: pueden estar vacíos o solo habilitar unidades nuevas -->
<tech name="EEXFortressizeHungary" type="Normal">
  <dbid>77194003</dbid>
  <status>UNOBTAINABLE</status>
  <flag>Shadow</flag>
  <prereqtech>EEXAge0Hungary</prereqtech>
  <effects>
  </effects>
</tech>
```

### Techs de político (age-up)

Los políticos **activan** el shadow tech de su edad. El prerrequisito controla cuándo
pueden ser investigados.

```xml
<tech name="EEXPoliticianHungaryColonial1" type="Normal">
  <status>UNOBTAINABLE</status>
  <prereqtech>EEXAge0Hungary</prereqtech>   <!-- Colonial: solo requiere estar en Discovery -->
  <effects>
    <effect type="TechStatus" status="active">EEXColonializeHungary</effect>
    <effect type="HomeCityShipment" unitname="CoveredWagon" count="1"></effect>
  </effects>
</tech>

<tech name="EEXPoliticianHungaryFortress1" type="Normal">
  <status>UNOBTAINABLE</status>
  <prereqtech>EEXColonializeHungary</prereqtech>  <!-- Fortress: requiere estar en Colonial -->
  <effects>
    <effect type="TechStatus" status="active">EEXFortressizeHungary</effect>
    <!-- ... envío de unidades ... -->
  </effects>
</tech>
```

### DERemoveAge — limpieza de políticos en la UI

Los techs `DERemoveAge3`, `DERemoveAge4`, `DERemoveAge5` existen en el juego base.
Para agregar efectos adicionales, usar `mergeMode="add"` en cada efecto individual:

```xml
<!-- DERemoveAge3 = se activa al entrar a Fortress → elimina políticos de Colonial -->
<tech name="DERemoveAge3" type="Normal">
  <effects>
    <effect mergeMode="add" type="CommandRemove" tech="EEXPoliticianHungaryColonial1">
      <target type="ProtoUnit">TownCenter</target>
    </effect>
    <!-- ... los otros políticos coloniales de las 3 civs ... -->
  </effects>
</tech>
<!-- DERemoveAge4 = al entrar a Industrial → elimina políticos de Fortress -->
<!-- DERemoveAge5 = al entrar a Imperial → elimina políticos de Industrial -->
```

---

## protomods.xml

### Modificar un edificio existente para agregar una unidad

```xml
<Unit mergeMode='modify' name="Barracks">
  <Train row="0" page="0" column="0">EEXHajduk</Train>
  <Tech row="0" page="1" column="0">EEXVeteranHajduk</Tech>
  <Tech row="0" page="1" column="1">EEXGuardHajduk</Tech>
</Unit>
```

### Definir una nueva unidad (sin nuevos assets)

```xml
<unit id="77191001" name="EEXHajduk">
  <dbid>77191001</dbid>
  <displaynameid>77181010</displaynameid>
  <populationcount>1</populationcount>
  <!-- ASSET REUTILIZADO: animación del juego base -->
  <animfile>units\infantry_ranged\musketeer\musketeer.xml</animfile>
  <!-- ASSETS REUTILIZADOS: iconos del juego base -->
  <icon>resources\art\units\infantry_ranged\musketeer\musketeer_icon_64x64.png</icon>
  <portraiticon>resources\art\units\infantry_ranged\musketeer\musketeer_portrait.png</portraiticon>
  <!-- ... stats, costs, tactics ... -->
</unit>
```

### Cartas de Home City en techtreemods.xml

El campo `<name>` de la carta en homecity[civ].xml es el nombre del tech en techtreemods.xml.
**No hay elemento `<tech>` separado.**

```xml
<!-- En homecityeexhungary.xml -->
<card>
  <name>EEXHCShipHajduk3</name>   <!-- Este ES el nombre del tech -->
  <age>0</age>
</card>

<!-- En techtreemods.xml -->
<tech name="EEXHCShipHajduk3" type="Normal">
  <flag>HomeCity</flag>
  <effects>
    <effect type="Data" amount="3.00" subtype="FreeHomeCityUnit" unittype="EEXHajduk" relativity="Absolute">
      <target type="Player"></target>
    </effect>
  </effects>
</tech>
```

---

## homecity[nombre].xml (nueva civ)

Para civilizaciones nuevas, el archivo tiene raíz `<homecity>` (no `<homecitymods>`).
El nombre del archivo debe ser `homecity` + nombre de la civ en minúsculas + `.xml`.

```xml
<homecity>
  <civ>EEXHungary</civ>
  <name>$$77181003$$</name>
  <heroname>$$77181004$$</heroname>
  <visual>german\german_homecity.xml</visual>
  <!-- ... otros campos visuales ... -->
  <heroprotounits>
    <protounit>EEXHungarianExplorer</protounit>
  </heroprotounits>
  <cards>
    <card>
      <name>EEXHCShipHajduk3</name>  <!-- Nombre del tech (sin elemento <tech> separado) -->
      <age>0</age>
      <maxcount>1</maxcount>
      <prereqtech>-1</prereqtech>
    </card>
  </cards>
</homecity>
```

---

## politicianmods.xml

```xml
<politicianmods>
  <EEXPoliticianHungaryColonial1
    portraitfilename="ui\ingame\politicians\politician_engineer"
    portraitfilenamewpf="resources/images/icons/politicians/politician_logistician.png">
  </EEXPoliticianHungaryColonial1>
</politicianmods>
```

---

## stringmods.xml

```xml
<stringmods>
  <stringtable>
    <language name="">
      <string _locid="77181001">Hungarians</string>
    </language>
  </stringtable>
</stringmods>
```

---

## Rutas de Assets del Juego Base

### Animaciones de unidades
- Musketero: `units\infantry_ranged\musketeer\musketeer.xml`
- Skirmisher: `units\infantry_ranged\skirmisher\skirmisher.xml`
- Hussar/Uhlan: `units\cavalry\uhlan\uhlan.xml`
- Dragoon: `units\cavalry\dragoon\dragoon.xml`
- Pikeman/Halberdier: `units\infantry_hand\halberdier\halberdier.xml`
- Grenadier: `units\infantry_ranged\grenadier\grenadier.xml`

### Iconos de unidades
- Musketero: `resources\art\units\infantry_ranged\musketeer\musketeer_icon_64x64.png`
- Skirmisher: `resources\art\units\infantry_ranged\skirmisher\skirmisher_icon_64x64.png`
- Hussar: `resources\art\units\cavalry\hussar\hussar_icon_64x64.png`
- Dragoon: `resources\art\units\cavalry\dragoon\dragoon_icon_64x64.png`
- Pikeman: `resources\art\units\infantry_hand\pikeman\pikeman_icon_64x64.png`

### Visuales de Home Cities reutilizados
- Alemana: `german\german_homecity.xml` (→ Hungría)
- Rusa: `russian\russian_homecity.xml` (→ Rumania)
- Sueca: `swedish\swedish_homecity.xml` (→ Finlandia)

> **NOTA**: Rutas verificadas contra el mod de referencia. Los paths de portraits
> (`musketeer_portrait.png` etc.) deben verificarse contra archivos reales del juego.

---

## Sonidos de unidad (`Sound/*_snds.xml`) — CRÍTICO para protos nuevos

**Descubrimiento clave**: los sonidos de unidad NO se definen en el proto (protoy.xml no
usa tags `<sound>`; solo existen `autoconvertsoundset`/`hitpercentsoundset`/`dodgesoundset`
para eventos puntuales). La voz/combate/muerte se resuelve así:

```
nombre de proto  →  Sound/<nombreproto-en-minúsculas>_snds.xml  →  <soundset>  →  WAV por civilización
```

- El juego carga automáticamente `Sound/<lowercase(protoname)>_snds.xml` para cada proto.
  Ej: `deSaloonHajduk` → `desaloonhajduk_snds.xml`; `Musketeer` → `musketeer_snds.xml`.
- Un `_snds.xml` es un `<protounitsounddef>` con `<protounit name="X">` y `<soundtype>`s
  (Select/Grunt/Death/Creation/Acknowledge) que apuntan a `<soundset name="...">`.
- Los soundsets resuelven a WAVs **por civilización** (`britishmusketeer*.wav`,
  `dutchmusketeer*.wav`, etc.) — esa es la "nomenclatura por civ".

**Consecuencia**: una unidad con un **nombre de proto nuevo** (ej. `HUNHajduk`) NO tiene
archivo `_snds.xml` → queda **muda**. Si toda la civ usa protos nuevos, **toda la civ
queda muda**. El animfile compartido NO trae la voz (se resuelve por nombre de proto).

**Solución** (por cada proto nuevo):
1. Crear `sound/<nombreproto-minúsculas>_snds.xml` copiando el `_snds.xml` de la unidad
   base y cambiando solo `<protounit name="BASE">` → `<protounit name="HUNXxx">`.
2. **Ubicación en el mod**: carpeta `sound/` en la **raíz del mod** (hermana de `data/`),
   replicando la estructura del juego donde `Sound/` es hermano de `Data/`. NO va bajo `data/`.
3. `AoE3Reference/Sound/` (extraído de `sound.bar`) es la fuente de estos archivos.

> La carpeta `AoE3Reference/Sound/` es pesada (miles de `.wav`) y está en `.gitignore`.

### Voz CUSTOM y voz por civ en protos COMPARTIDOS (patrón `.mods.xml`)

Para audio propio (el juego acepta **`.mp3`**, no solo `.wav`) se usa el patrón aditivo del
mod "Just Poland":

- **Archivos**: `sound/<carpeta>/<archivo>.mp3` (ej. `sound/hungary/explorer/...mp3`).
- **Soundsets aditivos**: un archivo `sound/soundsetsde.mods.xml` con root
  `<soundsetdefmods>` y `<soundset name="X" ...><sound filename="ruta\relativa.mp3"/></soundset>`.
  Se **mergea** con los soundsets base (no reemplaza). La ruta del `filename` es relativa a
  `sound/`.
- **Sound def aditivo**: `sound/<proto>_snds.mods.xml` con root `<protounitsounddefmods>` —
  **agrega** ramas a la sound def del proto sin reescribir el archivo entero.

**Dos casos según el proto:**
1. **Proto PROPIO** (ej. `HUNHonved`): se edita directo su `hun<...>_snds.xml` (o se crea);
   los `<soundtype>` apuntan a los soundsets custom. No hace falta civlogic.
2. **Proto COMPARTIDO** (ej. `Explorer`, `Falconet`): su sonido va por `<civlogic>` (rama por
   civ, key = `<name>` de la civ; ej. `Germans`, `DESwedish`, `STARKPolish`). Una civ nueva
   NO tiene rama → muda. Se agrega la rama con un `<proto>_snds.mods.xml` aditivo:

```xml
<protounitsounddefmods>
  <protounit name="Explorer">
    <soundtype name="Select">
      <civlogic><choice name="HUNHungarians">
        <soundset name="HungarianExplorerSelect"></soundset>
      </choice></civlogic>
    </soundtype>
    <soundtype name="Acknowledge">
      <civlogic><choice name="HUNHungarians"><targetlogic>
        <choice name="default"><soundset name="HungarianExplorerMove"></soundset></choice>
        <choice name="enemy"><soundset name="HungarianExplorerAttack"></soundset></choice>
      </targetlogic></choice></civlogic>
    </soundtype>
  </protounit>
</protounitsounddefmods>
```

Soundtypes útiles del Explorer: `Select`, `Acknowledge` (con `targetlogic` default=mover /
enemy=atacar), `Claim`, `KnockOut` (noqueado), `Ransomed`, `KnockOutRevived`.

## Clonar una civilización COMPLETA (2ª civ en el mismo mod)

Se puede tener **varias civs en un solo mod** (Hungría clona Germans, Finlandia clona Suecia,
en el mismo `mod-minimal`). Pasos (ver `civmods.xml`/`techtreemods.xml` reales):
1. `civmods.xml`: copiar 1:1 el bloque `<civ>` de la civ base (`DESwedish`) cambiando solo la
   identidad (`<name>`, `<statsid>`, `<displaynameid>`, `<homecityfilename>`), los `<agetech>`
   a techs propios y los campos WPF de bandera (reutilizar una civ de revolución con bandera
   propia, ej. `DERevFinland` → `objects\flags\finnish`, `Flag_Finnish.png`).
2. `techtreemods.xml`: age techs propios (`FINAge0`…) que **delegan** por
   `TechStatus active` a los de la civ base (`DEAge0Swedish`…). El roster propio se arma
   agregando enables/disables y `<Unit mergeMode='modify'>` de edificios en `FINAge0`.
3. `homecity<civ>.xml` (**nuevo**, clon del de la base) + `uitechtree/techtreedata_<civ>.xml`
   (**nuevo**, clon del árbol UI de la base — se nombra por civ en minúsculas).
4. Strings ES/EN. Usar un rango de IDs propio por civ (Hungría 88881xxx, Finlandia 88882xxx).
5. Un edificio compartido (Barracks, etc.) lleva las unidades de AMBAS civs en su train list;
   cada civ habilita/deshabilita las suyas en su Age0.
6. **`game/ai/<lider>.personality`** (**nuevo**) — sin esto la civ NO se puede asignar a la IA
   (ver abajo).

### Que la IA pueda usar la civ (`game/ai/*.personality`) — se olvida siempre

Registrar la civ en `civmods.xml` la hace seleccionable **solo para el jugador humano**. El
desplegable de civ de un slot de **IA** se llena desde los **archivos de personalidad**
(`Game/AI/*.personality` del juego): hay **22 personalidades ↔ 22 civs**, y cada una se ata a
su civ con **`<forcedciv>`** (`Frederick`→`Germans`, `Gustav`→`DESwedish`, …). Sin una
personalidad con `<forcedciv>MiCiv</forcedciv>`, **la IA no puede "ser" esa civ** y el juego
no la ofrece — aunque el humano sí pueda jugarla.

Un mod aporta personalidades en **`game/ai/`** en la **raíz del mod** (hermana de `data/` y
`sound/`). Formato: **UTF-8 con BOM**, CRLF (las del juego base son UTF-16; las de mods,
UTF-8-BOM):

```xml
<AI>
   <version>2</version>
   <script>aiLoaderStandard</script>
   <nameID>88881900</nameID>              <!-- string ES/EN: nombre mostrado del líder IA -->
   <tooltipID>88881901</tooltipID>
   <forcedciv>HUNHungarians</forcedciv>   <!-- ← el vínculo con la civ -->
   <rushboom>0</rushboom>
   <icon>resources/images/icons/flags/Flag_Hungarian.png</icon>
   <chatset>Frederick</chatset>           <!-- reusar un chatset base (el de la civ base) -->
   <playerNames>
      <nameID>88881900</nameID>
   </playerNames>
</AI>
```

**Alcance**: `aiLoaderStandard` es la IA base y no conoce protos ni cartas custom. Con una civ
clon (mismos edificios) juega razonablemente con las unidades base, pero no entrenará las
propias. Para IA "de verdad" hay que copiar el árbol `game/ai/core/*.xs` al mod y registrar la
civ en `aisetup.xs` y `aihccards.xs` (así lo hace el mod *Abstract Nations Plus*, id 312759 —
mejor referencia instalada; el mod *Just Poland* NO trae `game/ai/` y por eso su civ tampoco
es asignable a la IA).

### Unidades de "revolución" = protos base RENOMBRADOS (no unidades nuevas)

Las unidades de una revolución suelen ser **protos base transformados por la tech de revolución**,
no protos dedicados. En la revolución finlandesa (`DERevolutionFinland`):
- El **"Jaeger Carelio"** = el **Skirmisher**: `InitiateRevolution proto="Skirmisher"` (los
  colonos se convierten en Skirmisher), + `SetName`→"Karelian Jaeger" + `CopyUnitPortraitAndIcon`
  + costo 100 madera + `Gather`/`CrateGather` habilitados.
- El **"Savolax/Savonia Jaeger"** = `MercJaeger` modificado por `DEChurchSavolaxJaegers`
  (rename, +vida, sigilo, costo madera) — **sin cambio de animfile**.
- `deIconREV...` son **stubs de icono incompletos** (0 animfile/tactics) — NO usarlos como unidad.
- **Ojo con los nombres EN vs ES**: string 91617/91618 = "Savolax Jaeger" (inglés) pero
  "Jaeger de Savonia" (español) — **es la misma unidad**. Verificar el idioma del usuario.

### Skin de veterano (modelo distinto al mejorar)

Los modelos muestran una **skin de veterano/guardia** cuando el proto tiene una mejora
"veterana" activa. Se replica con el patrón de `VeteranMusketeers`: en un tech,
`Hitpoints` + `Damage` (BasePercent) + `SetName` + `UpdateVisual` sobre el proto. Es lo que
dispara el cambio de skin (no hay un modelo aparte). Depende del motor: si el animfile no
tiene variación de veterano o el proto no tiene mejora reconocida, la skin no cambia.

## Marcos e iconos de cartas de Home City

**Descubrimiento**: el juego **NO** dibuja el marco ornamentado verde/violeta de las
cartas. Se verificó que una carta base de equipo+infinita (`HCXPMercsHessiansRepeatTeam`)
tiene los MISMOS flags/propiedades que una custom (`TeamTech` + `YPInfiniteTech`) → el
juego las renderiza igual, con marco simple + overlays. El marco ornamentado es **arte
horneado en el PNG** (así lo hacen todos los mods: archivos tipo `mm_team_infinite_gold.png`,
`winged_hussar_icon_infinite.png`).

Semántica del marco horneado: **verde = equipo**, **violeta = infinito**, **verde+violeta
= equipo+infinito**.

**Buenas prácticas de icono de carta**:
- El juego dibuja automáticamente sobre el icono: el **∞** (infinito), el **número** de
  envío, las **monedas** (costo) y el **✓** (en mazo). NO hornear esos overlays en el
  PNG o se duplican.
- Si se usa arte de "carta completa" (con marco+∞+número), **borrar el ∞ y el número**
  (rellenando con el color de fondo local muestreado) y conservar solo el marco + retrato.
- Iconos a **256×256** (o 128) PNG real; reescalar desde la fuente HD con LANCZOS (no
  desde un PNG ya reducido). DDS-as-.png se ve pixelado; convertir a PNG real con Pillow.

**`<researchpoints>` = tiempo de envío**: en cartas Home City, `<researchpoints>` es el
tiempo entre pedir el envío y recibirlo (base usa `40`). Cartas sin ese campo llegan
instantáneas. Cartas de equipo: flag `TeamTech`. Infinitas: flag `YPInfiniteTech` +
`<maxcount>-1</maxcount>` en el pool. Costo en oro: `<cost resourcetype="Gold">` (además
del `Ships` 1).

## Unidades de consulado y mejoras "por edad"

Las unidades con `AbstractConsulateUnit` / `AbstractConsulateUnitColonial` (ej.
`deNatHungarianGrenadier`) reciben sus mejoras de edad **automáticamente** por el mecanismo
de consulado, no por techs en un edificio. Para tener una copia que se mejore con techs
**investigables en un edificio**:
1. Copiar el proto quitando `AbstractConsulateUnit` / `AbstractConsulateUnitColonial` (y el
   `<sharedselectionunittypes>` de merc/legión) → así deja de recibir las mejoras del consulado.
2. Crear techs `UpgradeTech` (Veteran/Guard/Imperial) que apunten al proto por nombre y
   agregarlas al edificio (`<Unit mergeMode='modify'>`), con prereq de edad **genérico**
   (`Fortressize`/`Industrialize`/`Imperialize`) para que se vean en gris antes de la edad.
3. En el Age0 de la civ: deshabilitar la unidad base y sus techs (`Enable 0` +
   `TechStatus unobtainable`), habilitar la propia y hacer `obtainable` las techs nuevas.

## Auras (NO son data-moddables)

Las auras de AoE3 DE (`HPAura`, `ShieldAura`, Mansabdar, Wignacourt, Tamborilero) están
atadas por el motor a unidades específicas (edificios/héroes concretos). **No existe** un
aura data-moddable de "boost de vida+ataque a unidades cercanas" aplicable a un proto
nuevo. El `WignacourtAuraRange` solo define el radio; el buff es hardcodeado. Descartar
pedidos de auras custom por datos.

## Posturas de combate (TacticArmor + multiplicadores por postura)

- **Armadura por postura** vía `subtype="TacticArmor" tactic="Volley|Stagger|Melee|..."
  armortype="Hand|Ranged|Siege"`. **Requiere que el proto tenga el slot de armadura base**
  (`<armor type="Hand" value="0.0">`); sin el slot, `TacticArmor` no aplica. Tipos válidos:
  `Hand` (melee), `Ranged` (a distancia), `Siege` (artillería/asedio) — no hay "artillería" aparte.
- **Multiplicadores por postura**: requieren protoactions DISTINTAS por postura
  (`RangedAttack`, `StaggerRangedAttack`, `HandAttack`…) y una **tactics propia** que mapee
  cada postura a su acción (patrón del fusilero Nizam). El animfile/anims deben coincidir
  con la tactics base para que disparen los sonidos.

---

## Trampas Comunes

| Error | Causa | Solución |
|---|---|---|
| Civ no aparece en el menú | `agetech` en civmods.xml no coincide con el nombre del tech | Verificar nombres exactos entre civmods.xml y techtreemods.xml |
| Civ no aparece en el selector de Escaramuza (sin errores en el log) | Faltan los campos WPF en civmods.xml: `homecityflagiconwpf`, `homecitypreviewwpf`, `homecityflagbuttonwpf`, `homecityflagbuttonset`, `homecityflagbuttonsetlarge` | El selector de Escaramuza es WPF y depende de estos campos, no solo de `homecityflagtexture`. Agregarlos todos, reutilizando assets existentes si la civ no tiene los propios (ver `docs/mre-hungary-report.md`) |
| Civ no aparece en NINGUNA lista de civs (Escaramuza, Ciudades Natales), datos fusionados correctos, sin errores | Falta `strings/<idioma-activo>/stringmods.xml` — el motor solo carga el idioma que coincide con el locale del juego, nunca los demás. Si el mod solo tiene `strings/english/` y el juego corre en español (u otro idioma), `displaynameid`/`rollovernameid` no resuelven a ningún texto | Crear `stringmods.xml` para CADA idioma en el que se vaya a probar el mod (mínimo: el idioma del juego del usuario). Verificar con `DebugOutputGameData` → `%TEMP%\Age of Empires 3 DE\Data\data\strings\<idioma>\` que las cadenas de la civ están en el idioma activo, no solo en inglés |
| Civ funciona perfecto en el editor de escenarios (dropdown, cartas, todo) pero NUNCA aparece en el selector de Escaramuza ni en Ciudades Natales, aunque `DebugOutputGameData` confirme que los datos fusionados son correctos | (sin confirmar aún) Posibles causas externas a los archivos del mod: (a) caché obsoleta en `Savegame\sp_<NombreCiv>_homecity.xml` / `-v11.dat` de una versión anterior/rota de la civ; (b) otro mod habilitado a la vez que registra una civ con el mismo nombre visible (`displaynameid` distinto pero mismo texto) | Borrar los archivos `sp_<NombreCiv>_homecity*` de la carpeta `Savegame` del perfil para forzar regeneración. Probar con un solo mod de civ nueva habilitado a la vez (revisar `Enabled Mods` en `Age3Log.txt`) |
| La civ se puede jugar como humano pero NO aparece al asignarle civ a un oponente/aliado **IA** | El selector de IA no lee `civmods.xml`: lee las **personalidades de IA** y cada una se ata a una civ con `<forcedciv>`. Si ninguna apunta a la civ nueva, la IA no puede serla | Crear `game/ai/<lider>.personality` (UTF-8 **con BOM**) en la raíz del mod con `<forcedciv>MiCiv</forcedciv>`, `<script>aiLoaderStandard</script>`, `<chatset>` de la civ base y `<nameID>`/`<tooltipID>` con strings propias. Acordarse de sincronizar también la carpeta `game/` al mod local |
| No hay edificios en el TC | Age0 tech no incluye `TownCenter` en los Enable | Agregar `TownCenter` y todos los edificios estándar |
| Explorador/Falconete (proto compartido) mudo para la civ nueva, aunque otras unidades suenen | Su sonido va por `<civlogic>` y no hay rama para la civ nueva | Agregar la rama `<choice name="NombreCiv">` con un `<proto>_snds.mods.xml` aditivo (root `<protounitsounddefmods>`) |
| Los `.mp3` custom no suenan | Soundsets no definidos o ruta mal | Definir los soundsets en `sound/soundsetsde.mods.xml` (root `<soundsetdefmods>`), `filename` relativo a `sound/`; el juego SÍ acepta `.mp3` |
| Unidad de revolución sale en T-pose / sin animar | Se usó un `deIconREV...` (stub sin animfile) o se emparejó el animfile con la tactics equivocada | Usar el proto base que la revolución renombra (ej. Skirmisher/MercJaeger); animfile y tactics deben ser compatibles |
| Busco una unidad por su nombre en español y no la encuentro | El nombre EN ≠ ES (ej. "Savolax Jaeger" = "Jaeger de Savonia") | Buscar por displaynameid en AMBOS idiomas |
| No hay políticos en el TC | Políticos no son `obtainable` desde Age0 | Mover todos los `obtainable` de políticos al Age0 tech |
| Políticos no desaparecen al subir de edad | Falta entradas en `DERemoveAge3/4/5` | Agregar `mergeMode="add"` `CommandRemove` effects |
| Unidades no visibles aunque habilitadas | `ArtilleryDepot` escrito como `Artillery Foundry` | Usar el nombre interno exacto del proto unit |
| Civ crashea al cargar | `ColonizeShadow` u otro tech ficticio referenciado | Remover todos los actives a techs que no existen |
| Todas las unidades de la civ **sin sonido** (mudas) | Los protos tienen nombres nuevos y no existe `Sound/<nombre>_snds.xml` para ellos (el sonido se resuelve por nombre de proto) | Crear un `_snds.xml` por proto nuevo en la carpeta `sound/` de la raíz del mod, copiando el de la unidad base y cambiando `<protounit name="X">` |
| Unidad nueva muda aunque comparte animfile con la base | La voz NO viene del animfile sino de `Sound/<nombreproto>_snds.xml` | Ídem: crear el `_snds.xml` con el nombre del proto nuevo |
| El marco ornamentado (verde/violeta) de la carta no aparece | El juego NO dibuja ese marco; es arte horneado en el icono | Hornear el marco en el PNG del icono (verde=equipo, violeta=infinito); ver sección de cartas |
| La carta muestra el ∞ o el número duplicados | Se horneó el ∞/número en el icono Y el juego dibuja los suyos encima | Borrar del PNG el ∞ y el número (rellenar con fondo local); dejar que el juego los ponga |
| El envío de carta llega instantáneo (sin viaje) | Falta `<researchpoints>` en el tech de la carta | Agregar `<researchpoints>40</researchpoints>` (tiempo de envío estándar) |
| `TacticArmor` no aplica armadura por postura | El proto no tiene el slot de armadura base de ese tipo | Agregar `<armor type="Hand\|Siege\|Ranged" value="0.0">` al proto |
| Unidad de consulado se mejora sola por edad (no con techs) | Tiene `AbstractConsulateUnit` / `AbstractConsulateUnitColonial` | Quitar esos unittypes en la copia y dar mejoras vía `UpgradeTech` en un edificio |
