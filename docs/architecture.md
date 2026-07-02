# Arquitectura del Mod: Eastern European Expansion (EEX)

## Visión General

Este mod agrega tres nuevas civilizaciones a Age of Empires III: Definitive Edition:
- **Hungría (EEXHungary)** — basada en Alemania
- **Rumania (EEXRomania)** — basada en el Imperio Otomano
- **Finlandia (EEXFinland)** — basada en Suecia

El mod reutiliza el 100% de assets existentes del juego (animaciones, modelos, texturas, sonidos, iconos).

---

## Principios de Diseño

1. **Sin nuevos assets**: No se crean modelos 3D, texturas, animaciones ni sonidos nuevos.
2. **Máxima reutilización**: Cada unidad referencia archivos de animación del juego base.
3. **Patrón del mod de referencia**: Se sigue el patrón del mod de Polonia (109541_just poland) como base de implementación.
4. **Escalabilidad**: La arquitectura permite agregar nuevas civilizaciones (Serbia, Noruega, etc.) replicando el patrón.

---

## Prefijos y Convenciones de Nombres

| Elemento | Convención | Ejemplo |
|---|---|---|
| Civilización | `EEX` + NombreCiv | `EEXHungary` |
| Unidades | `EEX` + NombreUnidad | `EEXHajduk` |
| Tecnologías | `EEX` + NombreTech | `EEXVeteranHajduk` |
| Age techs | `EEXAge0` + Civ | `EEXAge0Hungary` |
| Políticos | `EEXPolitician` + Rol + Civ | `EEXPoliticianLogisticianHungary` |
| Home cities | `homecityeex` + civ | `homecityeexhungary.xml` |

---

## Rangos de IDs

### String IDs (locid)

| Rango | Propósito |
|---|---|
| 77180001 - 77180999 | Strings comunes / compartidos |
| 77181001 - 77181999 | Hungría (nombres, descripciones) |
| 77182001 - 77182999 | Rumania (nombres, descripciones) |
| 77183001 - 77183999 | Finlandia (nombres, descripciones) |

### DB IDs (unidades y tecnologías)

| Rango | Propósito |
|---|---|
| 77191001 - 77191999 | Unidades de Hungría |
| 77192001 - 77192999 | Unidades de Rumania |
| 77193001 - 77193999 | Unidades de Finlandia |
| 77194001 - 77194999 | Tecnologías de Hungría |
| 77195001 - 77195999 | Tecnologías de Rumania |
| 77196001 - 77196999 | Tecnologías de Finlandia |

> **IMPORTANTE**: Estos rangos fueron elegidos para NO colisionar con el mod de Polonia que usa 77092xxx-77095xxx.

---

## Estructura de Carpetas

```
mod/
  data/
    strings/
      english/stringmods.xml
      french/stringmods.xml
      german/stringmods.xml
      spanish/stringmods.xml
      italian/stringmods.xml
      portuguese/stringmods.xml (brazil)
      russian/stringmods.xml
    civmods.xml              ← Definición de las 3 civilizaciones
    protomods.xml            ← Definición de unidades y modificaciones de edificios
    techtreemods.xml         ← Age techs, tecnologías de mejora, efectos de edad
    unittypesmods.xml        ← Tipos de unidad nuevos
    politicianmods.xml       ← Retratos de políticos
    randomnamemods.xml       ← Tablas de nombres aleatorios
    homecityeexhungary.xml   ← Cartas de Home City de Hungría
    homecityeexromania.xml   ← Cartas de Home City de Rumania
    homecityeexfinland.xml   ← Cartas de Home City de Finlandia
```

**No existe carpeta `art/` ni `sound/`** ya que todo se reutiliza del juego base.

---

## Flujo de Carga del Juego

1. El juego carga `civmods.xml` → registra las 3 nuevas civilizaciones con sus metadatos.
2. Para cada civ, carga el `homecity[nombre].xml` correspondiente → registra las cartas disponibles.
3. Cuando comienza una partida, el motor aplica el `Age0Tech` de la civ (ej: `EEXAge0Hungary`).
4. El Age0Tech contiene efectos `Enable` para cada unidad y edificio de esa civ.
5. El `protomods.xml` ya tiene las unidades en las colas de entrenamiento de los edificios.
6. Las unidades habilitadas aparecen en la UI; las no habilitadas permanecen ocultas.

---

## Cómo Agregar una Nueva Civilización (Guía Rápida)

1. Elegir una civ base históricamente apropiada.
2. Elegir un prefijo único (ej: `EEXSerbia`).
3. Asignar rangos de IDs (string: 77184xxx, unidades: 77197xxx, techs: 77198xxx).
4. En `civmods.xml`: agregar un bloque `<civ>` copiando el patrón de Hungría. Verificar
   que los nombres en `<agetech>` coincidan EXACTAMENTE con los nombres en techtreemods.xml.
5. En `protomods.xml`: agregar definiciones de unidades y modificar edificios.
6. En `techtreemods.xml`:
   - Agregar el `Age0Tech` con: todos los enables estándar europeos (TownCenter, HouseEast, Sheep,
     Capitol, ArtilleryDepot, Barracks, Stable, Plantation, TradingPost, Market, Arsenal, Outpost,
     Dock, CWallGate, paredes, deTavern, Settler, Priest, FieldHospital, artillería, barcos, xpSpy),
     plus los actives XPTrickle/AAStandardStartingTechs/DEEuropeanStandardTechs/Levy.
   - Hacer `obtainable` TODOS los políticos (Colonial + Fortress + Industrial + Imperial) desde Age0.
   - Hacer `obtainable` TODOS los upgrade techs (Veteran/Guard/Imperial) desde Age0.
   - Agregar los 4 shadow techs (Colonialize/Fortressize/Industrialize/Imperialize) — sin efectos
     extras, solo Enable de unidades específicas de esa edad si las hay.
   - Agregar los techs de politician (activan el shadow tech correspondiente).
   - Agregar los techs de upgrade de unidades con `prereqtech` correctos.
   - Agregar efectos en `DERemoveAge3/4/5` con `mergeMode="add"` para limpiar políticos al subir edad.
7. Crear `homecityeex[nombre].xml` copiando el de Hungría como base. Raíz: `<homecity>`.
8. En `politicianmods.xml`: agregar los políticos de la nueva civ.
9. En `randomnamemods.xml`: agregar entradas para Explorer y Fort.
10. En todos los `stringmods.xml`: agregar los strings del nuevo ID range.

---

## Referencias del Mod de Ejemplo (Polonia)

El mod de Polonia (`109541_just poland - polish civilization`) es la referencia principal.
Prefijo: `STARK`
Cultura: `EasternEurope`
Base visual: Alemana (`german\german_homecity.xml`)

Diferencias clave entre el mod Polonia y este mod:
- Polonia crea assets nuevos (animaciones `units\poles\*.xml`); este mod NO.
- Este mod referencia animaciones del juego base (`units\infantry_ranged\musketeer\musketeer.xml`).
- Las unidades de este mod reutilizan iconos y retratos del juego base.
