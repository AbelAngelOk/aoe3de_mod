# Eastern European Expansion (EEX)
### Age of Empires III: Definitive Edition — Custom Civilization Mod

Adds three new playable civilizations to AoE3DE: **Hungary**, **Romania**, and **Finland**.
All unit visuals reuse existing base-game assets — no new models, textures, or sounds required.

---

## Civilizations

### Hungary (`EEXHungary`)
- **Base**: Germany (Habsburg connection)
- **Home City**: Budapest (German visuals)
- **Unique Units**: Hajduk, Pandur, Grenz Infantry, Magyar Hussar, Hungarian Dragoon
- **Strengths**: Cost-efficient infantry (Hajduks), elite shock cavalry (Magyar Hussars)
- **Explorer**: Hungarian Explorer (German animations)

### Romania (`EEXRomania`)
- **Base**: Ottomans (historical vassal relationship)
- **Home City**: Bucharest (Russian visuals)
- **Unique Units**: Dorobant, Romanian Pandur, Seimeni, Curteni
- **Strengths**: Tough infantry (Dorobanți), versatile cavalry (Curteni), resilient Seimeni vs. cavalry
- **Explorer**: Romanian Explorer (Russian animations)

### Finland (`EEXFinland`)
- **Base**: Sweden (part of Sweden 1249–1809)
- **Home City**: Turku (Swedish visuals)
- **Unique Units**: Finnish Musketeer, Jaeger, Knekt, Hakkapeliitta, Finnish Dragoon
- **Strengths**: Fast elite cavalry (Hakkapeliitta), long-range forest skirmishers (Jaeger)
- **Explorer**: Finnish Explorer (Swedish animations)

---

## Installation

1. Copy the `mod/` folder into your AoE3DE mod directory:
   ```
   %USERPROFILE%\Games\Age of Empires 3 DE\<profile_id>\mods\local\EasternEuropeanExpansion\
   ```
2. Launch the game and enable the mod via **Mods** → **Local Mods**.
3. Select Hungary, Romania, or Finland in the **Civilization** picker.

---

## File Structure

```
mod/
  data/
    civmods.xml                  — Civ registration (Hungary, Romania, Finland)
    protomods.xml                — Unit definitions for all 3 civs
    techtreemods.xml             — Age techs, upgrade techs, politician techs, HC card techs
    politicianmods.xml           — Politician portrait images
    unittypesmods.xml            — Unit type category registrations
    randomnamemods.xml           — Random names for explorers and forts
    homecityeexhungary.xml       — Hungary home city cards
    homecityeexromania.xml       — Romania home city cards
    homecityeexfinland.xml       — Finland home city cards
    strings/
      english/stringmods.xml     — English localization
```

---

## Design Principles

- **No new assets**: All animations, icons, sounds, and models come from the base game.
- **Additive mod system**: All XML files use `mergeMode` to non-destructively extend base game data.
- **Enable/Disable system**: Units are in building queues for all civs; only the active civ's units are visible (controlled by Age0 shadow tech).
- **Scalable architecture**: Adding future civs (Serbia, Norway, Denmark...) follows the same pattern — see [docs/architecture.md](docs/architecture.md).

---

## ID Ranges

| Range | Purpose |
|---|---|
| 77181xxx | Hungary strings |
| 77182xxx | Romania strings |
| 77183xxx | Finland strings |
| 77191xxx | Hungary unit DB IDs |
| 77192xxx | Romania unit DB IDs |
| 77193xxx | Finland unit DB IDs |
| 77194xxx | Hungary tech DB IDs |
| 77195xxx | Romania tech DB IDs |
| 77196xxx | Finland tech DB IDs |

Chosen to avoid conflicts with the Poland mod (77092xxx–77095xxx).

---

## Known Limitations

- Unit portraits show base-game unit visuals (Musketeer, Hussar, etc.) rather than culturally specific portraits — this requires new art assets which this mod intentionally avoids.
- Flag buttons use the base-game flag set for the civ's visual base (German for Hungary, Russian for Romania, Swedish for Finland).
- Revolution options are inherited from the base civ but have not been fully customized for each EEX civ.
- Audio (unit quotes) is borrowed from base-game units.
