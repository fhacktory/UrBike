var express = require("express");
var bodyParser = require('body-parser');
var morgan = require("morgan");
var config = require("./config");

var app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(morgan('dev'));

app.post("/getNearFree", require("./nearFree"));
app.post("/getNearBike", require("./nearBike"));


var server = app.listen(config.port, function() {
    require("./stations.js").launch();
    console.log('Listening on port %d', server.address().port);
});
