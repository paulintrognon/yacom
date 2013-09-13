$ ->
	soldier = {}
	map = {}

	socket = io.connect('http://localhost:8080')

	$('#connect').click -> socket.emit('login')

	socket.on 'loadMap', (loadedMap) ->
		map = loadedMap
		_.each map, (row, x) ->
			_.each row, (terrainName, y) ->
				$('#board-square-'+x+'-'+y).removeClass('grass wood water void').addClass(terrainName);

	socket.on 'loadPlayer', (loadedSoldier) ->
		soldier = loadedSoldier
		console.log('Soldier loaded:', loadedSoldier);