# zt_tailor_schneiderei (Tailor & Fabric Workshop)

Massschneiderei- und Kleidungsanpassungssystem mit automatischer Fokuskamera und Component-Variation-Tuning fuer FiveM.

---

## Deutsch

### Features
- Automatische Fokuskamera auf Knochenpunkte (Torso / Beine) waehrend der Anpassung.
- Durchschalten von Textur- und Saumvarianten.
- Behebung von Mesh-Clipping ueber Standard-Unterbauten.
- Speichern der modifizierten Kleidungsbestandteile in MySQL.

### Abhaengigkeiten
- `ox_lib`
- `ox_target`
- `oxmysql`
- Beliebiges Core: `qbx_core`, `qb-core` oder `es_extended`

### Installation
1. `schema.sql` in die MySQL-Datenbank importieren.
2. Den Ordner `zt_tailor_schneiderei` in dein FiveM `resources`-Verzeichnis ablegen.
3. In `shared/config.lua` das genutzte Framework einstellen (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. In der `server.cfg` eintragen: `ensure zt_tailor_schneiderei`.

### Lizenz & Namensnennung
Dieses Projekt steht unter der MIT-Lizenz. Es darf frei genutzt, modifiziert und erweitert werden, solange der Urheber **Zenkner-Technology** im Quellcode und in Verteilungen namentlich genannt wird.

---

## English

### Features
- Automatic scripted focus cameras on ped bone indices (torso / legs) during tuning.
- Cycle through texture, seam, and pattern variations.
- Mesh-clipping fixes through standardized undershirt configurations.
- Modification persistence stored directly in MySQL.

### Dependencies
- `ox_lib`
- `ox_target`
- `oxmysql`
- Supported Core: `qbx_core`, `qb-core`, or `es_extended`

### Installation
1. Import `schema.sql` into your MySQL database.
2. Place the `zt_tailor_schneiderei` folder into your FiveM `resources` directory.
3. Configure your core framework in `shared/config.lua` (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. Add to your `server.cfg`: `ensure zt_tailor_schneiderei`.

### License & Attribution
This project is licensed under the MIT License. You are free to use and modify it, provided that attribution to **Zenkner-Technology** is preserved in all copies or substantial portions of the software.
