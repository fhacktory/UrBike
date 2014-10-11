var mongoose = require("mongoose");
var _ = require("lodash");
var jcdApi = require("./jcdApi");
var config = require("./config.js");

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

var citySchema = new Schema({
  contract_name: String,
  last_update: {type: Date, default: Date.now}
});
var City = mongoose.model('City', citySchema);

module.exports = {

    launch: function() {
        _.forEach(jcdApi.cities, updateCity)
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
    Station.update({name: station.name}, station, {upsert: true}, function(err, station) {});
}

function updateCity(cityName) {
    City.findOne({contract_name: cityName}, function(err, city) {
        if (!city)
            return City.create({contract_name: cityName, last_update: new Date(0)}, function(err, saved) {
                console.log(saved);
                updateCity(cityName)
            });
        var last_update = new Date(city.last_update);
        var now = new Date();
        if (Math.abs(last_update.getTime() - now.getTime()) > config.refreshFrequency)
        {
            jcdApi.getInfos(city.contract_name, function(err, body) {
                if (err)
                    return;
                var stations = JSON.parse(body);
                _.forEach(stations, extractInfos)
                city.last_update = new Date();
                city.save(function(err) {
                    var timeout = setTimeout(updateCity.bind(this, cityName), config.refreshFrequency + 1000);
                    timeout.unref();
                })
            })
        }
        else
        {
            var timeout = setTimeout(updateCity.bind(this, cityName), config.refreshFrequency - Math.abs(now.getTime() - last_update.getTime()) + 1000)
            timeout.unref();
        }
    })
}
