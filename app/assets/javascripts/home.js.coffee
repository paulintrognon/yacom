$ ->
	soldier = {}
	map = {}

	socket = io.connect('http://localhost:8080')

	$('#connect').click -> socket.emit('login')

	socket.on 'loadGame', (gameInfo) ->
		map = gameInfo.map
		soldier = gameInfo.soldier

		console.log(map);
		renderMap(map, soldier)


renderMap = (map, soldier) ->
	boardSize = 6
	$boardElem = $('#game-board');
	$boardElem.empty()
	for x in [(soldier.position.x - boardSize)..(soldier.position.x + boardSize)] by 1
		$row = $("<tr>", {class: "board-row"});
		for y in [(soldier.position.y - boardSize)..(soldier.position.y + boardSize)] by 1
			$div = $("<td>", {id: 'board-square-'+x+'-'+y, class: "board-square"});
			if(map.squares[x+';'+y])
				$div.addClass(map.squares[x+';'+y].terrain.name);
			else
				$div.addClass('void');
			$row.append($div);
		$boardElem.append($row);