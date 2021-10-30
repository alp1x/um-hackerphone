-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'uyuyorum'
description 'UM - Hacker Phone'
version '1.0.0'

ui_page 'nui/ui.html'
	files { 
		'nui/ui.html',
		'nui/assets/img/*.png',
		'nui/assets/css/*.css',
		'nui/assets/js/*.js',
	}
	
client_script {'client/client.lua'}
server_script {'server/server.lua'}