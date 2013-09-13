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



	return {
		x: Helpers.randWithout(1, 9, [3, 7, 9]),
		y: Helpers.randWithout(1, 9, [3, 7, 9])
	};
}