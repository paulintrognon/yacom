
exports.randWithout = function (from, to, exceptions) {

	if(!exceptions) {
		exceptions = [];
	}

	exceptions.sort();

	var number = _.random(from, to - exceptions.length)

	_.each(exceptions, function(exception) {
		if(number >= exception) {
			number++;
		}
		else {
			return number;
		}
	});

	return number;
}
