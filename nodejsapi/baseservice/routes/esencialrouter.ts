import * as express from 'express';
import { Logger } from '../common'
import { EsencialController_pooling } from '../controllers'
import { EsencialController_no_pooling } from '../controllers'
import { EsencialController_ORM } from '../controllers'

const app = express();
const log = new Logger();

app.get("/getProducers_pooling", (req, res) => {
    EsencialController_pooling.getInstance().getProducers()
    .then((data:any)=>{
        res.json(data);
    })
    .catch((err:any)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });
});

app.get("/getProducers_no_pooling", (req, res) => {
    EsencialController_no_pooling.getInstance().getProducers()
    .then((data:any)=>{
        res.json(data);
    })
    .catch((err:any)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });
});

app.get("/getProducers_ORM", (req, res) => {
    EsencialController_ORM.getInstance().getProducers()
    .then((data:any)=>{
        res.json(data);
    })
    .catch((err:any)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });
});
export { app as esencialrouter };