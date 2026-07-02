# Additive Data Mods — Referencia Oficial AoE3 DE

Fuente: documentación oficial de Age of Empires III: Definitive Edition (support.ageofempires.com)

---

## ¿Qué son los Additive Data Mods?

En el sistema antiguo de modding, el mod tomaba una copia completa de un archivo de datos del juego y la sobreescribía. Esto causaba dos problemas:

- **Incompatibilidad con parches**: cuando el juego se actualiza, el mod queda invalidado y debe rehacerse.
- **Incompatibilidad entre mods**: si dos mods modifican el mismo archivo, no pueden estar activos al mismo tiempo.

Con additive mods, el archivo del mod se **fusiona** con los datos base. Esto significa:

- Los parches del juego no invalidan el mod (la fusión se aplica sobre la nueva versión del archivo base).
- Múltiples mods pueden modificar el mismo archivo base sin conflictos.

---

## Cómo usar

1. Colocar el archivo additive en la carpeta `Data/` del mod.
2. El nombre del archivo y el nodo raíz XML deben seguir la tabla oficial (ver abajo).
3. Usar el atributo `mergeMode` en cada nodo para controlar cómo se fusiona.

### Valores de mergeMode

| mergeMode | Comportamiento |
|---|---|
| `modify` | (default si el nodo existe en datos base) Fusiona con el nodo base |
| `add` | (default si el nodo NO existe en datos base) Agrega como nuevo elemento |
| `remove` | Elimina el nodo de los datos base |
| `replace` | Reemplaza completamente el nodo base |

> **Excepción**: `stringmods.xml` **no soporta mergeMode**. Los IDs definidos en el mod se añaden al pool global de strings siempre que sean únicos y no colisionen con el juego base ni con otros mods.

---

## Ejemplos de código

### protomods.xml — los 4 modos

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

### techtreemods.xml — agregar un effect a un tech existente

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

### stringmods.xml — sin mergeMode

```xml
<stringmods>
   <StringTable>
      <Language name='English'>
         <String _locID='20038'>ModContinue</String>
      </Language>
   </StringTable>
</stringmods>
```

---

## DebugOutputGameData

Para verificar que el mod se fusiona correctamente con los datos base, activar la variable `DebugOutputGameData`.

**Cómo activarla:**

Agregar la siguiente línea al archivo:
```
C:\Users\<user>\Games\Age of Empires 3 DE\<id>\Startup\user.cfg
```
(Crear el archivo si no existe.)

El motor escribirá todos los datos fusionados en:
```
%TEMP%\Age of Empires 3 DE\Data\
```
(ej: `C:\Users\<user>\AppData\Local\Temp\Age of Empires 3 DE\Data\`)

**Flujo recomendado:**

1. Activar la variable y ejecutar el juego **sin** mods → guardar los archivos base generados.
2. Activar el mod y ejecutar de nuevo → comparar los archivos fusionados para confirmar los cambios.

---

## Tabla completa de archivos additive soportados

| Archivo base del juego | Archivo en el mod | Nodo raíz XML |
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

> **Nota sobre home cities nuevas**: La fila `homecity<civ>.mods.xml` / `<homecitymods>` es para **modificar** una home city existente. Para civilizaciones nuevas, se crea `homecity<nombre>.xml` con raíz `<homecity>` — es un archivo completo nuevo, no un mod additive de uno existente.
