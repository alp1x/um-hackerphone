fx_version 'cerulean'
game 'gta5' 

author 'uyuyorum, Mickeystix'
description 'UM - Hacker Phone'
version '2.0.0'
ui_page 'nui/ui.html'

files { 
		'config.js',
		'nui/ui.html',
		'nui/assets/img/*.png',
		'nui/assets/css/*.css',
		'nui/assets/js/*.js',
		'nui/assets/sounds/*.mp3'
}
	
client_scripts {'client/anim.lua','client/client.lua'}
server_scripts {'@oxmysql/lib/MySQL.lua','server/server.lua','server/utils.lua','server/dbm.lua'}