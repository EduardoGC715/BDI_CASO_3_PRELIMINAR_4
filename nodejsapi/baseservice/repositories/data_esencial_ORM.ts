import { Logger } from '../common';
import { Sequelize, DataTypes, Model } from 'sequelize';

const sequelize = new Sequelize('Esencial Verde', 'dbuser', '123456789', {
    host: 'localhost',
    dialect: 'mssql'
});

export class data_esencial_ORM {
  private static instance: data_esencial_ORM;
  private log: Logger;
  private ProducerModel: any;
  private AddressModel: any;

  constructor() {
    this.log = new Logger();
    this.initializeModels();
  }

  public static getInstance(): data_esencial_ORM {
    if (!data_esencial_ORM.instance) {
      data_esencial_ORM.instance = new data_esencial_ORM();
    }
    return data_esencial_ORM.instance;
  }

  private initializeModels() {
    this.ProducerModel = sequelize.define('producers', {
      producer_id: {type: DataTypes.INTEGER, primaryKey: true},
      address_id: DataTypes.INTEGER,
      name: DataTypes.STRING,
      env_score: DataTypes.INTEGER,
    });
    
    this.AddressModel = sequelize.define('addresses', {
      address_id: {type: DataTypes.INTEGER, primaryKey: true},
      zip_code: DataTypes.STRING
    });
    
    this.AddressModel.hasMany(this.ProducerModel, { foreignKey: 'address_id' });
    this.ProducerModel.belongsTo(this.AddressModel, { foreignKey: 'address_id' });
  }

  public async getProducers(): Promise<any[]> {
    try {
      const producers = await this.ProducerModel.findAll({
        limit: 1000,
        order: [['env_score', 'DESC']],
        attributes: ['name', 'env_score'],
        include:{model: this.AddressModel, attributes: ['address_id', 'zip_code'], required: true}
      });
      return producers;
    } catch (err) {
      console.error('Error:', err);
      throw err;
    }
  }
}

