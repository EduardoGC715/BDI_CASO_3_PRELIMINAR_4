"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var app_1 = require("./app");
var http = require("http");
var common_1 = require("./common");
var port = 5000;
var logger = new common_1.Logger();
app_1.default.set('port', port);
var server = http.createServer(app_1.default);
server.listen(port);
server.on('listening', function () {
    var addr = server.address();
    var bind = (typeof addr === 'string') ? "pipe ".concat(addr) : "port ".concat(addr.port);
    logger.info("Listening on ".concat(bind));
});
module.exports = app_1.default;
// docker run -it -p 5000:5000 --name nodeserver -v C:\dev\cursostec\baseservice:/home/baseservice node /bin/bash
