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
    }

    public async getProducers(): Promise<any> {
        try {
          const connection = await sql.connect(sqlConfig);
          const request = new sql.Request(connection);
          const result = await request.execute('get_producers');
          sql.close();
          return result;
        } catch (err) {
          console.error('Error executing database query:', err);
          throw err;
        }
      }
}