fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'zt_drivingschool'
author 'Zenkner-Technology'
description 'Driving School with Dual Brake Controls & Tablet / Fahrschulsystem mit Doppelbedienung'
version '1.0.0'

shared_scripts {
    '@ox_lib/package.lua',
    'shared/config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/style.css',
    'web/dist/app.js'
}
