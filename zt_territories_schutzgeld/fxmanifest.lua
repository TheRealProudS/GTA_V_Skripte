fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'zt_territories'
author 'Zenkner-Technology'
description 'Territory Influence & Protection Racketeering System / Schutzgeld & Reviersystem'
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
