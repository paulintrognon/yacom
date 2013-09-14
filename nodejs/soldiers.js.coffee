exports.generateSoldier = (name) ->
	name: name
	lifePoints: 50
	weapon: {
		name: 'Glock'
		damage: 7
	}
	position: generatePos()
	baseSight: 4
	getSight: (map) ->
		terrain = map.getTerrain(@position)
		return {
			fromX: if @position.x - (@baseSight + terrain.sightBonus) >= 1 then @position.x - (@baseSight + terrain.sightBonus) else 1
			toX:   if @position.x + (@baseSight + terrain.sightBonus) <= map.width then @position.x + (@baseSight + terrain.sightBonus) else map.width
			fromY: if @position.y - (@baseSight + terrain.sightBonus) >= 1 then @position.y - (@baseSight + terrain.sightBonus) else 1
			toY:   if @position.y + (@baseSight + terrain.sightBonus) <= map.height then @position.y + (@baseSight + terrain.sightBonus) else map.height
		}

generatePos = ->
	x: 24
	y: 10