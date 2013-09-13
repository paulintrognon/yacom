$ ->
	soldier = {}
	socket = io.connect('http://localhost:8080')
	$('#connect').click -> socket.emit('login')
	socket.on 'loadPlayer', (loadedSoldier) ->
		soldier = loadedSoldier
		console.log('Soldier loaded:', loadedSoldier);