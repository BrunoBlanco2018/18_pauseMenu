fx_version 'bodacious'
game 'gta5'

author 'BB18'
description 'Clean progressbar'
version '0.1.0'

shared_script 'config.lua'

client_scripts {
    'config.lua',
    'cl.lua'
}

server_scripts {
    'config.lua',
    'sv.lua'
}

files {
    'html/index.html',
    'html/img/discord.svg',
    'html/img/exit.svg',
    'html/img/map.svg',
    'html/img/mapbg.svg',
    'html/img/resume.svg',
    'html/img/settings.svg',
    'html/img/shield.png',
    'html/img/yourlogo.png'   
}

-- Indica el archivo HTML principal para el entorno web
ui_page 'html/index.html'

shared_script '@es_extended/imports.lua'