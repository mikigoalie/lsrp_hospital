fx_version 'cerulean'
game 'gta5'

author 'mauriziopatino'
description 'code clean up and edit by mikigoalie#8148'

shared_scripts {
    'config.lua',
    'locales/locales.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
} 

client_scripts {
    'client/main.lua'
}

