import { Logger } from '../common'
import { data_esencial_ORM } from '../repositories/data_esencial_ORM'


export class EsencialController_ORM {
    private static instance: EsencialController_ORM;
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

    public static getInstance() : EsencialController_ORM
    {
        if (!this.instance)
        {
            this.instance = new EsencialController_ORM();
        }
        return this.instance;
    }

    public getProducers() : Promise<any> 
    {
        const esencialdata = data_esencial_ORM.getInstance();
        return esencialdata.getProducers();
    }
}
