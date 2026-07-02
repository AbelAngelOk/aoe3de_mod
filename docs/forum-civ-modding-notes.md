# Notas de foro: Modding de civilizaciones personalizadas

Fuente: foros de la comunidad (marzo 2023)

---

## Guía básica de creación de civilización (AoH3)

> Referencia general de modding. El flujo de carpetas y archivos difiere de AoE3 DE, pero los principios son similares.

### Principios generales

1. El modding no es lo mismo que programar. Los archivos del juego tienen un formato predefinido — entenderlos es más importante que saber programar.
2. El desarrollador prioriza la simplicidad; los mods pueden transformar el juego completamente sin código.
3. Existen mods de ejemplo oficiales (civilizaciones, mapas, unidades). Usarlos como plantilla ahorra tiempo.
4. Trial and error es normal. Un buen flujo de trabajo es copiar un mod existente, renombrar todo, y modificar de a poco.

### Estructura de carpetas (AoH3)

```
mod/
  mod.txt
  logo.png
  game/
    civilizations/
      TAG/
        civ.json
    gfx/
      flagsTAGH/
        TAG.png           (154×100 px, PNG)
    languages/
      Bundle.properties
      Bundle_xx.properties
```

### Archivo civ.json

```json
{
  "Tag": "exampleciv",
  "Name": "Example Civilization",
  "iR": 120,
  "iG": 80,
  "iB": 200,
  "ReligionID": 0,
  "GroupID": 0,
  "Wiki": "optional"
}
```

- Los valores RGB van de 0 a 255.
- Tags de religión custom deben ser ≥ 29; de grupo custom ≥ 14.
- El nombre puede ir directamente en `"Name"` o en `Bundle.properties` como `exampleciv = Example Civilization`.

---

## Problema: no aparece botón de avance de edad en el Town Center (AoE3 DE)

**Autor: MortiusMaximus (marzo 2023)**

### Problema reportado

Al crear una civilización personalizada desde cero en AoE3 DE, el Town Center no mostraba el botón de avance de edad. Síntomas:

- Mod funciona: las unidades nuevas aparecen si se agregan con `effect type="Data" subtype="AddTrain"`.
- El botón de edad no aparece en ningún caso.
- Copiar `civmods.xml` y `homecity(name).xml` de otro mod (Argentina) y solo cambiar nombres tampoco solucionaba el problema.
- Ninguna configuración de `Colonialize`, `Fortressize`, etc. en `techtreemods.xml` hacía diferencia.

### Causa identificada

**Respuesta de HoopThrower:** "¿Ya modificaste `politiciandata`?"

**Confirmación de MortiusMaximus:**
> "Eso fue todo… intenté durante días y en cuanto hice la publicación descubrí el problema. Una vez que volví a poner las cosas de políticos en `techtreemods.xml`, recuperé la capacidad de avanzar de edad."

La solución fue **copiar los techs de político del mod de Argentina** dentro de su `techtreemods.xml`.

### Lección clave

> **Sin los techs de político en `techtreemods.xml` (y/o en `politicianmods.xml`), el Town Center no muestra el botón de avance de edad, aunque `Colonialize` y la cadena de edad estén correctamente definidos.**

Los techs de político son los que:
1. Aparecen como opciones en el TC al avanzar de era.
2. Contienen `<flag>AgeUpgrade</flag>` y `<effect type="SetAge">Age1</effect>`.
3. Son activados (`TechStatus status="obtainable"`) por el tech de Age0 de la civilización.

Sin ellos, el engine no registra ninguna opción de avance de edad para el TC.

### Duda pendiente del autor (relevante para diseño)

> "¿Importa que los políticos sean españoles? ¿Esas cosas como `unlockpoliticiannaturalistspanish` y `depolicianinventorcolonial` deciden algo? ¿Son las opciones que aparecen al avanzar de edad?"

**Respuesta implícita:** Sí. Cada tech de político define:
- El **nombre** que aparece en el TC (via `displaynameid`).
- El **efecto** al elegirlo (bonus de unidades, recursos, etc.).
- El **ícono** de era que se muestra.

Para una civ custom, los políticos deben ser techs propios con IDs únicos, efectos propios y strings propios.

---

## Relevancia para el mod EEX

Esta discusión confirma exactamente el patrón que se implementó:

| Requisito para que aparezca el botón de edad | Estado en EEX |
|---|---|
| Techs de político en `techtreemods.xml` con `AgeUpgrade` | ✅ 36 techs (12 por civ × 3 civs) |
| Techs activados por `Age0` via `TechStatus obtainable` | ✅ En EEXAge0Hungary/Romania/Finland |
| `SetAge Age1/2/3/4` en cada político | ✅ Añadido en sesión anterior |
| Sin `prereqtech` en los políticos (igual que Polen) | ✅ Removido en sesión actual |
| Entradas en `politicianmods.xml` | ✅ Definidas para los 36 políticos |
