resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Blarglebottoms Ambulance Mission'

server_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'client/map.lua',
    'client/log.lua',
    'client/blips.lua',
    'client/markers.lua',
    'client/peds.lua',
    'client/overlay.lua',
    'client/scaleform.lua',
    'client/main.lua'
}

dependencies {
    'es_extended'
}
