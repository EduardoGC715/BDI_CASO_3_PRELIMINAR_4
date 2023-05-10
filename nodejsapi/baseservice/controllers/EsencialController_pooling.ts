import { Logger } from '../common'
import { data_esencial_pooling } from '../repositories/data_esencial_pooling'


export class EsencialController_pooling {
    private static instance: EsencialController_pooling;
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

    public static getInstance() : EsencialController_pooling
    {
        if (!this.instance)
        {
            this.instance = new EsencialController_pooling();
        }
        return this.instance;
    }

    public getProducers() : Promise<any> 
    {
        const esencialdata = data_esencial_pooling.getInstance();
        return esencialdata.getProducers();
    }
}