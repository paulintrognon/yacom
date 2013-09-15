$ ->
	soldier = {}
	map = {}

	socket = io.connect('http://localhost:8080')

	$('#connect').click -> socket.emit('login', $('#name').val())

	socket.on 'loadSoldier', (soldier) ->

		renderMap(soldier)

# RENDERING MAP #
renderMap = (soldier) ->

	map = soldier.mapSight
	console.log(map)

	# --- COORDNATES MATH --- #

	# board size : 2 defaults size + custom : choice left to user
	boardSize = 4

	#Calculating coords range for local map
	fromY = soldier.position.y - boardSize
	toY = soldier.position.y + boardSize
	fromX = soldier.position.x - boardSize
	toX = soldier.position.x + boardSize

	# --- GENERATING BOARD --- #

	#Getting board element and emptying it
	$board = $('#game-board');
	$board.empty()

	#Generating board borders (coordonates information)
	$firstRow = $("<tr>", {class: "board-row"});
	$firstRow.append("<th></th>")
	for x in [fromX..toX] by 1
		$firstRow.append("<th>#{x}</th>")

	$firstRow.append("<th></th>")
	$board.append($firstRow);

	for y in [fromY..toY] by 1
		$row = $("<tr>", {class: "board-row"});
		$row.append("<th>#{y}</th>")

		for x in [fromX..toX] by 1
			$td = $("<td>", {id: 'board-square-'+x+'-'+y, class: "board-square"});

			#terrain class lookup
			if(map.squares[x+';'+y])
				square = map.squares[x+';'+y];
				$td.addClass(square.terrain.name);

				#soldier lookup
				if(square.soldier)
					$img = $('<img>', {
						id: square.soldier.id+'-smiley',
						src: '/img/weapons/'+square.soldier.weapon.name+'/'+square.soldier.weapon.name+'-static.gif'
						class: 'soldier-smiley'
					})
					$td.append($img)

			else if(x < 1 || y < 1 || x > map.width || y > map.height)
				$td.addClass('void');
			else
				$td.addClass('unknown');

			$row.append($td)
		$row.append("<th>#{y}</th>")
		$board.append($row)
	$board.append($firstRow.clone());