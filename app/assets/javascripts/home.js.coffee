$ ->
	socket = io.connect 'http://localhost:8080'
	$('#connect').click => socket.emit('login')