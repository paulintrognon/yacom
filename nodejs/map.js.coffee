
# TERRAINS ---

terrains =

	water:
		name: 'water'
		walkable: false

	road:
		name: 'road'
		walkable: true
		movement: 1
		camouflagePenalty: 5
		sightBonus: 1

	grass:
		name: 'grass'
		walkable: true
		movement: 2
		camouflagePenalty: 3
		sightBonus: 0

	wood:
		name: 'wood'
		walkable: true
		movement: 3
		camouflagePenalty: 1
		sightBonus: -1

	swamp:
		name: 'swamp'
		walkable: true
		movement: 4
		camouflagePenalty: 2
		sightBonus: 0

# ------------

exports.generateMap = (width, height) ->
	map =
		width: width
		height: height
		squares: {}
		getSoldierSight: (soldier) ->
			sight = soldier.getSight(this)
			soldierSight = {}
			for x in [sight.fromX..sight.toX] by 1
				for y in [sight.fromY..sight.toY] by 1
					soldierSight[x+';'+y] = @getSquare({x: x, y: y})
			return {
				width: sight.toX - sight.fromX
				height: sight.toY - sight.fromY
				squares: soldierSight
			};

		getSquare: (position) -> @squares[position.x+';'+position.y]
		getTerrain: (position) -> @getSquare(position).terrain


	for x in [1..width] by 1
		for y in [1..height] by 1
			map.squares[x+';'+y] =
				position: {x: x, y: y}
				terrain: terrains[generateTerrain()]
				object: null
				soldier: null

	return map

generateTerrain = -> _.sample(['water', 'grass', 'grass', 'grass', 'grass','grass','grass', 'grass', 'wood','wood', 'wood'])
