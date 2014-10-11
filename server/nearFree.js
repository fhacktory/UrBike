var stations = require("./stations.js");

module.exports = function(req, res) {

    if (!req.body.lat || !req.body.lng)
        return res.status(401).send({error: "You need to specify lat and lng"})

    stations.searchFree([Number(req.body.lat), Number(req.body.lng)], function(err, stations) {
        if (err)
        {
            console.log(err);
            return res.status(500).send(err);
        }
        res.send(stations);
    })

}
