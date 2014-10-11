var stations = require("./stations.js");

module.exports = function(req, res) {

    if (!req.body.lat || !req.body.lng)
        return res.status(401).send({error: "You need to specify lat and lng"})

    stations.searchFree([Number(req.body.lng), Number(req.body.lat)], function(err, stations) {
        if (err)
        {
            console.log(err);
            return res.status(500).send(err);
        }
        res.send(stations);
    })

}
