resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Blarglebottoms Ambulance Mission'

server_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'client/stream.lua',
    'client/log.lua',
    'client/blips.lua',
    'client/markers.lua',
    'client/peds.lua',
    'client/overlay.lua',
    'client/scaleform.lua',
    'client/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'es_extended'
}
