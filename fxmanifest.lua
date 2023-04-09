fx_version 'cerulean'
game 'gta5'

lua54 'yes'

ui_page 'html/index.html'
files { 'html/index.html', 'html/**/**/*.*' }

shared_scripts {
    '@es_extended/imports.lua',
    'config/sh_config.lua',
}
server_script 'server/main.lua'
client_script 'client/*.lua'

escrow_ignore {
    'html/index.html',
    'html/**/**/*.*',
    'config/*.lua',
    'client/commands.lua'
}