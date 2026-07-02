# TODO — Eastern European Expansion (EEX)

## Pendiente (necesario para probar en juego)

- [ ] **Verificar rutas de assets**: Usar `DebugOutputGameData` (agregar al `user.cfg` en Startup/) para ver los datos fusionados y verificar que los Enable toman efecto. Luego confirmar con el Resource Manager del juego que los paths de animación/icono existen:
  - `units\infantry_ranged\musketeer\musketeer.xml`
  - `resources\art\units\cavalry\hussar\hussar_icon_64x64.png`
  - etc.
- [ ] **Verificar portrait icon paths**: Confirmar que `musketeer_portrait.png`, `hussar_portrait.png` etc. existen exactamente en esas rutas en los archivos del juego
- [ ] **Probar en juego**: Iniciar partida con cada civ y verificar:
  - Los edificios estándar aparecen en el Town Center desde el inicio
  - Los políticos correctos aparecen al subir de edad
  - Los políticos de la edad anterior desaparecen tras el age-up
  - Las unidades propias (Hajduk, Magyar Hussar, etc.) están visibles en Barracks/Stable
  - Las cartas de Home City funcionan y envían las unidades correctas
- [ ] **Balance pass**: Ajustar HP/daño/costo de unidades tras observar el desempeño en juego

## Prioridad Media (v1.0 polish)

- [ ] **Strings adicionales**: Agregar tablas para otros idiomas (French, Spanish, German, Portuguese, Russian) copiando la estructura del stringmods.xml en inglés
- [ ] **Bonificaciones de civ**: Implementar bonificaciones reales en los Age0 techs:
  - Hungría: Magyar Hussar disponible desde Colonial age (actualmente requiere Colonial)
  - Rumania: Edificios cuestan 15% menos madera
  - Finlandia: Hakkapeliitta cuesta menos madera, disponible desde Colonial
- [ ] **Cartas de mejoras adicionales**: Agregar cartas HCImproveXxx para cada civ
- [ ] **Nombres aleatorios**: Completar nombres reales húngaros/rumanos/finlandeses en stringmods.xml

## Baja Prioridad (versiones futuras)

- [ ] **Íconos de bandera personalizados**: Crear 3 imágenes PNG para la pantalla de selección de civ
- [ ] **Serbia (EEXSerbia)**: Nueva civ siguiendo la misma arquitectura
- [ ] **Noruega (EEXNorway)**: Nueva civ
- [ ] **Dinamarca (EEXDenmark)**: Nueva civ
- [ ] **Soporte de IA**: Verificar/crear archivos de personalidad de IA para las civs EEX

## Problemas Conocidos (pendientes de verificación)

- Los paths de portrait icon (`_portrait.png`) podrían no existir en esas rutas exactas — verificar con Resource Manager
- `unittype` values en `FreeHomeCityUnit` deben coincidir con nombres registrados en proto.xml del juego
- `Stable` y `Church` se habilitaron explícitamente en Age0 aunque puede que `DEEuropeanStandardTechs` ya los active — sin efecto negativo si se duplica
