# ##############
# GLOBAL CLASSES
# ##############

# Underscore.js
global._ = require('underscore');

# Helpers - custom functions
global.Helpers = require('./helpers');



httpModule = require 'http'

httpServer = httpModule.createServer (req, res) ->
	res.write('Test')
	res.end()

httpServer.listen(8080)

io = require('socket.io').listen(httpServer)

# ############
# GAME MODULES
# ############

mapModule = require('./map.js.coffee');
soldiersModule = require('./soldiers.js.coffee');

YACOM =
	map: mapModule.generateMap(50, 50)
	soldiers: {}

io.sockets.on 'connection', (socket) ->

	soldierName = null

	# soldier LOGIN -----------------------
	socket.on 'login', (name) ->
		soldierName = name

		if !YACOM.soldiers[soldierName]
			YACOM.soldiers[soldierName] = soldiersModule.generateSoldier(soldierName)


		socket.emit 'loadGame',
			soldier: YACOM.soldiers[name]
			map: YACOM.map.getSoldierSight(YACOM.soldiers[soldierName])