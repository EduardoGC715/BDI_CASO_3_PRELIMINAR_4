import { Logger } from '../common'

const sql = require('mssql')

const sqlConfig = {
    user: "dbuser",
    password: "123456789",
    database: "Esencial Verde",
    server: "localhost\\MSSQLSERVER",
    options: {
      encrypt: true, 
      trustServerCertificate: true 
    }
}

export class data_esencial_no_pooling {
    private log: Logger;

    public constructor()
    {
        this.log = new Logger();

        // via singleton, accediendo a un solo pool tengo una conexiona la base de datos
    }

    public getProducers() : Promise<any>
    {
        return sql.connect(sqlConfig).then((pool:any) => {
            return pool.request()
                .execute("get_producers")
        })
    }
}