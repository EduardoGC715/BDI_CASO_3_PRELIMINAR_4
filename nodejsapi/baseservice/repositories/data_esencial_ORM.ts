import { Logger } from '../common';
import { Sequelize, DataTypes, Model } from 'sequelize';

const sequelize = new Sequelize('Esencial Verde', 'dbuser', '123456789', {
    host: 'localhost',
    dialect: 'mssql'
});

export class data_esencial_ORM {
  private static instance: data_esencial_ORM;
  private log: Logger;

  private constructor() {
    this.log = new Logger();
    sequelize.authenticate()
        .then(()=>{
            console.log("Conexion a base OK")
        })
        .catch(error=>{
            console.log("Error en la conexion: " + error)
        })
    }

  public static getInstance(): data_esencial_ORM {
    if (!data_esencial_ORM.instance) {
      data_esencial_ORM.instance = new data_esencial_ORM();
    }

    return data_esencial_ORM.instance;
  }

  public async getProducers(): Promise<any[]> {
    try {
      const [producers, metadata] = await sequelize.query('EXEC get_producers');
      return producers;
    } catch (err) {
      console.error('Error executing getProducers:', err);
      throw err;
    }
  }
}

