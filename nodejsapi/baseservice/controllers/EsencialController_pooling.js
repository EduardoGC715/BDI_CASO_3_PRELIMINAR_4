"use strict";
exports.__esModule = true;
exports.EsencialController_pooling = void 0;
var common_1 = require("../common");
var data_esencial_pooling_1 = require("../repositories/data_esencial_pooling");
var EsencialController_pooling = /** @class */ (function () {
    function EsencialController_pooling() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    EsencialController_pooling.getInstance = function () {
        if (!this.instance) {
            this.instance = new EsencialController_pooling();
        }
        return this.instance;
    };
    EsencialController_pooling.prototype.getProducers = function () {
        var esencialdata = data_esencial_pooling_1.data_esencial_pooling.getInstance();
        return esencialdata.getProducers();
    };
    return EsencialController_pooling;
}());
exports.EsencialController_pooling = EsencialController_pooling;
