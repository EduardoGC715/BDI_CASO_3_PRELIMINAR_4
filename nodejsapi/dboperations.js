var config = require('./dbconfig');
const sql = require('mssql');

async function getProducers(){
    try {
        let pool = await sql.connect(config);
        let products = await pool.request().query('EXEC get_producers');
        return products.recordsets;
    }
    catch (error){
        console.log(error)
    }
}

module.exports = {
    getProducers : getProducers
}