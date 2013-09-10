var http = require('http');

var httpServer = http.createServer(function(req, res) {
    res.write('Test');
    res.end();
});

httpServer.listen(8080);