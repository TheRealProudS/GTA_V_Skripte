Config = {}

Config.Core = 'qbx'
Config.Inventory = 'ox_inventory'

Config.TickInterval = 600000

Config.DefaultShare = 0.15

Config.AuthorizedGangs = {
    ['ballas'] = true,
    ['families'] = true,
    ['vagos'] = true
}

Config.Shops = {
    ['ltd_grove'] = {
        label = 'LTD Gasoline Grove St',
        coords = vector3(1163.67, -323.92, 69.21),
        zone = 'davis',
        defaultPot = 2500,
        rate = 1500
    },
    ['247_innocence'] = {
        label = '24/7 Supermarket Innocence',
        coords = vector3(25.74, -1347.31, 29.5),
        zone = 'strawberry',
        defaultPot = 3200,
        rate = 1800
    }
}
