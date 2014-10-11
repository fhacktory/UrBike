var mongoose = require("mongoose");
var _ = require("lodash");
var jcdApi = require("./jcdApi");

mongoose.connect('mongodb://localhost/urbike');

var Schema = mongoose.Schema;

var stationSchema = new Schema({
  name: String,
  position: {
    type: [Number],
    index: '2d'
  },
  contract_name: String,
  status: String,
  bike_stands: Number,
  available_bikes: Number,
  available_bike_stands: Number,
  last_update: {type: Date, default: Date.now}
});
var Station = mongoose.model('Station', stationSchema);

module.exports = {

    launch: function() {
        _.forEach(jcdApi.cities, function(city) {
            jcdApi.getInfos(city, function(err, body) {
                if (err)
                    return;
                var stations = JSON.parse(body);
                _.forEach(stations, extractInfos)
            })
        })
    },

    searchBike: function(position, callback) {

        Station.find({
            available_bikes: {$gt: 0},
            position: {$near: position}
        }).limit(5).exec(function(err, stations) {
            callback(err, stations);
        });

    },

    searchFree: function(position, callback) {

        Station.find({
            available_bike_stands: {$gt: 0},
            position: {$near: position}
        }).limit(5).exec(function(err, stations) {
            callback(err, stations);
        });

    },

}

function extractInfos(station) {

    station.position = [station.position.lat, station.position.lng];
    Station.update({name: station.name}, station, {upsert: true}, function(err, station) {
    });

}

