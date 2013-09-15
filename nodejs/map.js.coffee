
# TERRAINS ---

terrains =

	water:
		name: 'water'
		isisWalkable: false

	road:
		name: 'road'
		isWalkable: true
		movement: 1
		camouflagePenalty: 5
		sightBonus: 1

	grass:
		name: 'grass'
		isWalkable: true
		movement: 2
		camouflagePenalty: 3
		sightBonus: 0

	wood:
		name: 'wood'
		isWalkable: true
		movement: 3
		camouflagePenalty: 1
		sightBonus: -1

	swamp:
		name: 'swamp'
		isWalkable: true
		movement: 4
		camouflagePenalty: 2
		sightBonus: 0

# ------------

exports.generateMap = (width, height) ->

	# CLASS MAP
	map =
		# ATTRIBUTES
		#------------
		width: width
		height: height
		squares: {}

		# METHODS
		#---------

		#-- GETTERS --

		#Get square from position
		getSquare: (position) -> @squares[position.x+';'+position.y]

		#get terrain from position
		getTerrain: (position) -> @getSquare(position).terrain

		#-- GENERATORS --

		generatePos: (army) ->
			availableSquares = []
			for key, square of @squares
				#If there is no soldier on this square
				if(square.terrain.isWalkable && !square.soldier)
					availableSquares.push(square.position)
			_.sample(availableSquares)

		#-- SOLDIERS --

		#Add soldier to map
		addSoldier: (soldier) ->
			@squares[soldier.position.x+';'+soldier.position.y].soldierId = soldier.id
	#END MAP CLASS



	# GENERATING MAP CONTENT (terrains)
	for x in [1..width] by 1
		for y in [1..height] by 1
			map.squares[x+';'+y] =
				position: {x: x, y: y}
				terrain: terrains[generateTerrain()]
				object: null
				soldierId: null

	#returning generated map
	return map

generateTerrain = -> _.sample(['water', 'grass', 'grass', 'grass', 'grass','grass','grass', 'grass', 'wood','wood', 'wood'])
