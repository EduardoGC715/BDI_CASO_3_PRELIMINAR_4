import { Logger } from '../common';
import { Connection, Request } from 'tedious';

const sqlConfig = {
    server: "localhost",
    options: {
      database: "Esencial Verde",
      encrypt: true,
      trustServerCertificate: true,
      rowCollectionOnDone: true,
      rowCollectionOnRequestCompletion: true,
      useColumnNames: true
    },
    authentication: {
      type: "default",
      options: {  
        userName: "dbuser",
        password: "123456789",
      }
    }
  };

export class data_esencial_no_pooling {
  private connection: Connection;
  private log: Logger;

   constructor() {
    this.connection = new Connection(sqlConfig);
    this.log = new Logger();
  }

  private connect(): Promise<void> {
    return new Promise<void>((resolve, reject) => {
      this.connection.on("connect", (err: Error) => {
        if (err) {
          reject(err);
        } else {
          console.log('Connectedwithout connection pooling');
          resolve();
        }
      });
      this.connection.connect();
    });
  }

  public async getProducers(): Promise<any> {
    try {
        await this.connect();
      return new Promise<any>((resolve, reject) => {
        const request = new Request('get_producers', (err: Error, rowCount: number, rows:any) => {
          if (err) {
            console.error('Error:', err);
            reject(err);
          } else {
            resolve({rows});
            this.connection.close();
          }
        });
        this.connection.callProcedure(request);
      });
    } catch (err) {
      console.error('Error:', err);
      throw err;
    }
  }
}