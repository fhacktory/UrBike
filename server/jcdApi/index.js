var request = require('request');
var config = require("../config");

module.exports = {
    cities: [
        "Lyon",
        "Paris",
        "Toulouse",
        "Rouen",
        "Nantes",
        "Nancy",
        "Mulhouse",
        "Marseille",
        "Creteil",
        "Besancon",
        "Amiens"],

    getInfos: function(city, callback) {
        request("https://api.jcdecaux.com/vls/v1/stations?contract=" + city + "&apiKey=" + config.jcdApiKey,
            function(error, response, body) {
                callback(error, body);
            });
    }
}
