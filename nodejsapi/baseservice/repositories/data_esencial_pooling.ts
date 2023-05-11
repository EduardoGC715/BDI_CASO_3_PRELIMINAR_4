import { Logger } from '../common'

const sql = require('mssql')

const sqlConfig = {
    user: "dbuser",
    password: "123456789",
    database: "Esencial Verde",
    server: "localhost\\MSSQLSERVER",
    pool: {
        max: 10,
        min: 5,
        idleTimeoutMillis: 30000
    },
    options: {
      encrypt: true, 
      trustServerCertificate: true 
    }
}

export class data_esencial_pooling {
    private static instance: data_esencial_pooling;
    private pool: any;
    private log: Logger;
  
    private constructor() {
      this.pool = new sql.ConnectionPool(sqlConfig);
      //this.pool.connect();
      this.log = new Logger();
    }
    public static getInstance(): data_esencial_pooling {
        if (!data_esencial_pooling.instance) {
            data_esencial_pooling.instance = new data_esencial_pooling();
        }

        return data_esencial_pooling.instance;
    }
    public async getProducers(): Promise<any> {
      try {
        await this.pool.connect();
        console.log('Connected with connection pooling');
        const request = this.pool.request();
        const result = await request.execute('get_producers');
        return result;
      } catch (err) {
        console.error('Error executing database query:', err);
        throw err;
      }
    }
  }