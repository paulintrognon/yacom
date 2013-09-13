var generatePlayer = function(name, map) {

	var player = {
		name: name,
		lifePoints: 50,
		weapon: {
			name: 'Glock',
			damage: 7
		},
		position: generatePos(map)
	};

	return player;
};
exports.generatePlayer = generatePlayer;

function generatePos(map) {
	return {x:0, y:0};
}