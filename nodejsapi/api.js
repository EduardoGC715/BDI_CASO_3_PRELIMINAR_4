var producer = require('./producer')
const dboperations = require('./dboperations');

dboperations.getProducers().then(result=> {
    console.log(result)
})