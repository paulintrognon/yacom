
exports.generateSoldier = (soldierName) ->
	id : soldierName
	name : soldierName
	baseLifePoints: 50
	baseSight: 4
	weapon: {
		name: 'berreta92'
		nameDisplay: 'Berreta 92'
		damage: 7
	}
	position: YACOM.map.generatePos()

	getSelfClientSoldier: ->
		id : @id
		name : @name
		baseLifePoints: @baseLifePoints
		baseSight: @baseSight
		weapon: @weapon
		position: @position
		mapSight: @getMapSight()

	getOtherClientSoldier: ->
		id : @id
		name: @name
		position: @position
		weapon: {
			name: @weapon.name
			nameDisplay: @weapon.nameDisplay
		}

	getMapSight: ->
		sightCoordinates = @getSightCoordinates()
		squares = {}
		for x in [sightCoordinates.fromX..sightCoordinates.toX] by 1
			for y in [sightCoordinates.fromY..sightCoordinates.toY] by 1
				square = YACOM.map.getSquare({x:x,y:y})
				clientSquare =
					position: square.position
					terrain: square.terrain
					soldier: null
				if(square.soldierId)
					soldier = YACOM.soldiers[square.soldierId]
					clientSquare.soldier = soldier.getOtherClientSoldier()

				squares[x+';'+y] = clientSquare

		return {
			width: YACOM.map.width
			height: YACOM.map.height
			squares: squares
		};

	getSightCoordinates: ->
		terrain = YACOM.map.getTerrain(@position)
		return {
			fromX: if @position.x - (@baseSight + terrain.sightBonus) >= 1					then @position.x - (@baseSight + terrain.sightBonus) else 1
			toX:   if @position.x + (@baseSight + terrain.sightBonus) <= YACOM.map.width 	then @position.x + (@baseSight + terrain.sightBonus) else YACOM.map.width
			fromY: if @position.y - (@baseSight + terrain.sightBonus) >= 1 					then @position.y - (@baseSight + terrain.sightBonus) else 1
			toY:   if @position.y + (@baseSight + terrain.sightBonus) <= YACOM.map.height	then @position.y + (@baseSight + terrain.sightBonus) else YACOM.map.height
		}

