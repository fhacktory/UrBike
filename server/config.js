module.exports = {
    port: process.env.PORT || 9000,
    jcdApiKey: process.env.jcdApiKey,
    mongoUri: process.env.MONGOLAB_URI || 'mongodb://localhost/urbike',
    refreshFrequency: 5 * 60 * 1000
}
