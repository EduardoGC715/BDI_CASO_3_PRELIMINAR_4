"use strict";
exports.__esModule = true;
exports.EsencialController_no_pooling = void 0;
var common_1 = require("../common");
var data_esencial_no_pooling_1 = require("../repositories/data_esencial_no_pooling");
var EsencialController_no_pooling = /** @class */ (function () {
    function EsencialController_no_pooling() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    EsencialController_no_pooling.getInstance = function () {
        if (!this.instance) {
            this.instance = new EsencialController_no_pooling();
        }
        return this.instance;
    };
    EsencialController_no_pooling.prototype.getProducers = function () {
        var esencialdata = data_esencial_no_pooling_1.data_esencial_no_pooling.getInstance();
        return esencialdata.getProducers();
    };
    return EsencialController_no_pooling;
}());
exports.EsencialController_no_pooling = EsencialController_no_pooling;
