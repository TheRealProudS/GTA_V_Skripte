# zt_territories_schutzgeld (Territory Influence & Protection Racketeering)

Modernes Reviereinfluss- und Schutzgeldsystem fuer FiveM.

---

## Deutsch

### Features
- Automatische Zonen- und Ladenregistrierung via Target (`ox_target`).
- Verhandlung und Ueberschreiben von Schutzvertraegen durch Gangs.
- Automatischer Zuwachs im Schutzgeld-Depot ueber Server-Ticker.
- Sicheres Abholen von Schwarzgeld aus den Laeden.

### Abhaengigkeiten
- `ox_lib`
- `ox_target`
- `oxmysql`
- Beliebiges Core: `qbx_core`, `qb-core` oder `es_extended`
- Inventar: `ox_inventory` (empfohlen) oder Standard-Core Accounts

### Installation
1. `schema.sql` in die MySQL-Datenbank importieren.
2. Den Ordner `zt_territories_schutzgeld` in dein FiveM `resources`-Verzeichnis ablegen.
3. In `shared/config.lua` das genutzte Framework einstellen (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. In der `server.cfg` eintragen: `ensure zt_territories_schutzgeld`.

### Lizenz & Namensnennung
Dieses Projekt steht unter der MIT-Lizenz. Es darf frei genutzt, modifiziert und erweitert werden, solange der Urheber **Zenkner-Technology** im Quellcode und in Verteilungen namentlich genannt wird.

---

## English

### Features
- Automatic zone and shop registration via targeting (`ox_target`).
- Negotiation and overriding of protection racketeering contracts by gangs.
- Automatic depot accrual over time via server ticker.
- Secure withdrawal of dirty money from registered shops.

### Dependencies
- `ox_lib`
- `ox_target`
- `oxmysql`
- Supported Core: `qbx_core`, `qb-core`, or `es_extended`
- Inventory: `ox_inventory` (recommended) or standard core accounts

### Installation
1. Import `schema.sql` into your MySQL database.
2. Place the `zt_territories_schutzgeld` folder into your FiveM `resources` directory.
3. Configure your core framework in `shared/config.lua` (`Config.Core = 'qbx' | 'qb' | 'esx'`).
4. Add to your `server.cfg`: `ensure zt_territories_schutzgeld`.

### License & Attribution
This project is licensed under the MIT License. You are free to use and modify it, provided that attribution to **Zenkner-Technology** is preserved in all copies or substantial portions of the software.
