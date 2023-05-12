import { Logger } from '../common'
import { data_esencial_no_pooling } from '../repositories/data_esencial_no_pooling'


export class EsencialController_no_pooling {
    private static instance: EsencialController_no_pooling;
    private log: Logger;

    private constructor()
    {
        this.log = new Logger();
        try
        {
        } catch (e)
        {
            this.log.error(e);
        }
    }

    public static getInstance() : EsencialController_no_pooling
    {
        if (!this.instance)
        {
            this.instance = new EsencialController_no_pooling();
        }
        return this.instance;
    }

    public getProducers() : Promise<any> 
    {
        const esencialdata = new data_esencial_no_pooling;
        return esencialdata.getProducers();
    }
}