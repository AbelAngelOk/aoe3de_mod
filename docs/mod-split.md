# División de `mod-minimal` en dos mods (2026-09-19)

`mod-minimal/` (monolítico, 14 civs) se dividió en dos mods independientes para poder aislar
problemas. `mod-minimal/` sigue en el repo sin cambios como respaldo del original, pero **ya no
es la fuente que se instala**: se edita en `mod-hungria/` y `mod-civs/`.

| Repo | Instalado en `mods\local\` | Contenido |
|---|---|---|
| `mod-hungria/` | `hungria` | Hungría (`HUN`), Hungría Otomana (`HOT`) y Hungría Alemana (`HGE`). Comparten unidades `HUN*` (Hajduk, Crabat, Grenzer, Pandur...) |
| `mod-civs/` | `civs-nuevas` | Finlandia, Argentina, Egipto, Holanda Italiana, Rumania, Hospitalarios, Berberiscos, Colombia, Chile, Francia Napoleónica, Indias Orientales |

Ambos quedaron **desactivados** en `age3-mod-status.json` (junto con `minimal-hungary` y
`localmod2`). No activar `minimal-hungary` junto con los dos nuevos: duplicaría todo.

## Reglas del reparto
- **Datos** (`civmods`, `techtreemods`, `protomods`): por prefijo (`HUN`/`HOT`/`HGE` → hungria,
  el resto → civs). En los bloques `<Unit mergeMode='modify'>` (Barracks, Stable, etc.) cada
  `<train>`/`<tech>` va al mod dueño de la unidad/tech.
- **Textos**: por quién usa cada `locid` (ninguno se repite entre mods).
- **Sonido**: `*_snds.xml` por proto; los `*_snds.mods.xml` con `<civlogic>` (settler, explorer,
  culverin) quedaron partidos por civ y existen en ambos mods con el mismo nombre. Los 22
  soundsets `MM*` que usaban ambos mods (Otomano, Sahin...) se renombraron con sufijo `Civs` en
  `mod-civs` para no chocar.
- **Rumania** usaba `HUNHajduk`/`HUNCrabat` y sus mejoras: ahora tiene clones propios
  (`ROUHajduk` id 88888209, `ROUCrabat` 88888210, techs `ROU{Veteran,Guard,Imperial}Hajduk`
  dbid 88888330-332, locids 88888300-311, `rouHajduk.tactics`) para que `mod-civs` no dependa de
  `mod-hungria`.
- No hay ids, techs, protos, civs, statsid, locids ni soundsets repetidos entre los dos mods
  (verificado con script).

## Sin verificar en juego
Que el juego fusione dos archivos `*_snds.mods.xml` del mismo nombre provenientes de mods
distintos (settler/explorer/culverin). Si con ambos activos alguna civ queda muda, es lo primero
a revisar.
