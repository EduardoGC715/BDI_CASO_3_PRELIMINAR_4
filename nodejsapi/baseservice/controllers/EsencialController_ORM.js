"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EsencialController_ORM = void 0;
var common_1 = require("../common");
var data_esencial_ORM_1 = require("../repositories/data_esencial_ORM");
var EsencialController_ORM = /** @class */ (function () {
    function EsencialController_ORM() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    EsencialController_ORM.getInstance = function () {
        if (!this.instance) {
            this.instance = new EsencialController_ORM();
        }
        return this.instance;
    };
    EsencialController_ORM.prototype.getProducers = function () {
        var esencialdata = data_esencial_ORM_1.data_esencial_ORM.getInstance();
        return esencialdata.getProducers();
    };
    return EsencialController_ORM;
}());
exports.EsencialController_ORM = EsencialController_ORM;
