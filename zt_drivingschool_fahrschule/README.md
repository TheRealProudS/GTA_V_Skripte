# zt_drivingschool_fahrschule (Driving School with Dual Controls & Tablet)

Fahrschulsystem mit Doppelbedienung (Beifahrer-Notbremse) und NUI-Theoriepruefung.

---

## Deutsch

### Features
- Integrierte NUI-Theoriepruefung mit dynamischem Fragenkatalog.
- Beifahrer-Notbremse via Doppelpedal fuer Fahrlehrer auf Sitz 0.
- Praktische Pruefungsabnahme durch Fahrlehrer.
- Speicherung des Lizenzstatus in MySQL.

### Abhaengigkeiten
- `ox_lib`
- `ox_target`
- `oxmysql`
- Beliebiges Core: `qbx_core`, `qb-core` oder `es_extended`

### Tastenbelegung
- Fahrlehrer Notbremse: Standardmaessig `LEERTASTE` (konfigurierbar in `shared/config.lua`).

### Installation
1. `schema.sql` in die MySQL-Datenbank importieren.
2. Den Ordner `zt_drivingschool_fahrschule` in dein FiveM `resources`-Verzeichnis ablegen.
3. In `shared/config.lua` das genutzte Framework einstellen (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. In der `server.cfg` eintragen: `ensure zt_drivingschool_fahrschule`.

### Lizenz & Namensnennung
Dieses Projekt steht unter der MIT-Lizenz. Es darf frei genutzt, modifiziert und erweitert werden, solange der Urheber **Zenkner-Technology** im Quellcode und in Verteilungen namentlich genannt wird.

---

## English

### Features
- Responsive NUI theory examination with dynamic questionnaire.
- Passenger dual-brake controls for instructors occupying seat 0.
- Practical exam sign-off by licensed instructors.
- License status stored persistently in MySQL.

### Dependencies
- `ox_lib`
- `ox_target`
- `oxmysql`
- Supported Core: `qbx_core`, `qb-core`, or `es_extended`

### Keybinds
- Instructor Emergency Brake: Default `SPACEBAR` (customizable in `shared/config.lua`).

### Installation
1. Import `schema.sql` into your MySQL database.
2. Place the `zt_drivingschool_fahrschule` folder into your FiveM `resources` directory.
3. Configure your core framework in `shared/config.lua` (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. Add to your `server.cfg`: `ensure zt_drivingschool_fahrschule`.

### License & Attribution
This project is licensed under the MIT License. You are free to use and modify it, provided that attribution to **Zenkner-Technology** is preserved in all copies or substantial portions of the software.
