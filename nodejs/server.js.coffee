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

global.YACOM =
	map: mapModule.generateMap(50, 50)
	soldiers: {}

io.sockets.on 'connection', (socket) ->

	soldierId = null

	# soldier LOGIN -----------------------
	socket.on 'login', (name) ->

		soldierId = name

		if !YACOM.soldiers[soldierId]
			YACOM.soldiers[soldierId] = new soldiersModule.generateSoldier(name)
			YACOM.map.addSoldier(YACOM.soldiers[soldierId])

		socket.emit 'loadSoldier', YACOM.soldiers[soldierId].getSelfClientSoldier()