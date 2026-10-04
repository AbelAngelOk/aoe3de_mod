# Propuestas de nuevas civilizaciones

Estos `.md` son **propuestas sin implementar** (2026-09-09) — listas de features tal como las
pidió el usuario, transcritas para no perderlas, SIN tocar ningún archivo del mod todavía.
No confundir con `docs/civs/` (civs YA implementadas en `mod-minimal`, 8 hasta ahora).

Cuando se decida implementar una de estas, seguir el proceso habitual: elegir civ base real
que clone, asignar rango de IDs propio (el siguiente libre después de 88888xxx/Rumania), y
aplicar el checklist de `docs/civilization-design.md` ("Reglas anti-bugs recurrentes").

| Propuesta | Base real / revolución real identificada (2026-09-09) | Archivo |
|---|---|---|
| Caballeros Hospitalarios | ✅ **IMPLEMENTADA v10.0** — ver `docs/civs/09-caballeros-hospitalarios.md` | [caballeros-hospitalarios.md](caballeros-hospitalarios.md) |
| Orden del Grial | sin match real encontrado — sigue sin base definida | [orden-del-grial.md](orden-del-grial.md) |
| Chile | ✅ **IMPLEMENTADA v13.0** — ver `docs/civs/12-chile.md` | [chile.md](chile.md) |
| Colombia | ✅ **IMPLEMENTADA v12.0** — ver `docs/civs/11-colombia.md` | [colombia.md](colombia.md) |
| Canadienses | `DERevolutionCanadaFrench`/`CanadaBritish` (revolución real, ⚠️ mecánica real distinta a la pedida) | [canadienses.md](canadienses.md) |
| Sudáfrica | `DERevolutionSouthAfrica` (revolución real, ⚠️ mecánica real distinta a la pedida) | [sudafrica.md](sudafrica.md) |
| Francia Napoleónica | ✅ **IMPLEMENTADA v14.0** — ver `docs/civs/13-francia-napoleonica.md` | [francia-napoleonica.md](francia-napoleonica.md) |
| Brasil | `DERevolutionBrazil` existe pero ⚠️ mecánica real (Voluntario da Patria) no tiene nada que ver con el pedido | [brasil.md](brasil.md) |
| Indias Orientales Neerlandesas | ✅ **IMPLEMENTADA v15.0** — ver `docs/civs/14-indias-orientales-neerlandesas.md` | [indias-orientales-neerlandesas.md](indias-orientales-neerlandesas.md) |
| Estados Berberiscos | ✅ **IMPLEMENTADA v11.0** — ver `docs/civs/10-estados-berberiscos.md` | [estados-berberiscos.md](estados-berberiscos.md) |
| Estados Pontificios | sin revolución real, pero las 10 unidades del roster son casi todas protos reales confirmados | [estados-pontificios.md](estados-pontificios.md) |

**Hallazgo transversal más importante**: de las 11 propuestas, **9 corresponden a contenido
real ya existente en el juego** (una civ completa, 7 revoluciones reales, o un roster de
mercenarios reales) — solo "Orden del Grial" quedó sin ningún match real identificado. Antes
de implementar, en varios casos (Canadienses, Sudáfrica, Brasil) la mecánica REAL de la
revolución **no coincide** con lo que pidió el usuario — hay que decidir explícitamente si se
sigue el diseño real o el diseño propio pedido (marcado `⚠️` en cada doc).

**Notas de transcripción**: se copiaron los nombres de unidades/techs/cartas EXACTAMENTE como
los escribió el usuario. Varios se verificaron contra los datos reales
(`AoE3Reference/Data/`) — ver cada doc para el detalle punto por punto. Los que siguen sin
verificar están marcados `⚠️`.
