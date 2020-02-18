fx_version 'adamant'

game 'gta5'

description 'Blarglebottoms Ambulance Mission'

server_scripts {
    '@es_extended/locale.lua',
    'src/lib/wrapper.lua',
    'config.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'src/server/main.lua'
}

ui_page 'html/index.html'

client_scripts {
    '@es_extended/locale.lua',
    'src/lib/wrapper.lua',
    'config.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'src/lib/stream.lua',
    'src/lib/log.lua',
    'src/client/blips.lua',
    'src/client/markers.lua',
    'src/client/peds.lua',
    'src/client/overlay.lua',
    'src/client/scaleform.lua',
    'src/client/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'es_extended'
}
