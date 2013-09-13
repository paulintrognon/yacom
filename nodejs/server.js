/*************************
 *  SETTING UP SERVER *
 *************************/

global._ = require('underscore');
global.Helpers = require('./helpers');

var httpModule = require('http');

var httpServer = httpModule.createServer(function(req, res) {
	res.write('Test');
	res.end();
});

httpServer.listen(8080);

var io = require('socket.io').listen(httpServer);

/*************************
 *  GAME VARIABLES *
 *************************/

var mapModule = require('./maps');
var playersModule = require('./players');

var map = null;

/*************************
 *  CONNECTION MODULE *
 *************************/

io.sockets.on('connection', function(socket) {

	if(map == null) {
		map = mapModule.generateMap(9);
	}
	socket.emit('loadMap', map.terrains);

	var player = null;

	socket.on('login', function(name) {

		if(map.players[name]) {
			player = map.players[name];
		}
		else {
			player = playersModule.generatePlayer(name, map);
//			map.players[name] = player;
		}

		socket.emit('loadPlayer', player);
	});


});
