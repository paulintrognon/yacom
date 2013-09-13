var generateMap = function(size) {

	var map = {
		size: size,
		terrains: {},
		players: {}
	};

	for(i = 1 ; i <= size ; i++) {

		map.terrains[i] = {};

		for(j = 1 ; j <= size ; j++) {

			map.terrains[i][j] = generateTerrain();

		}
	}

	return map;
};

exports.generateMap = generateMap;

function generateTerrain() {

	var terrains = ['water', 'grass', 'grass', 'grass', 'wood', 'wood'];

	return terrains[Math.floor(Math.random() * terrains.length)];

}