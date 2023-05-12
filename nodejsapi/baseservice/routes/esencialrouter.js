"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.esencialrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var controllers_1 = require("../controllers");
var controllers_2 = require("../controllers");
var controllers_3 = require("../controllers");
var app = express();
exports.esencialrouter = app;
var log = new common_1.Logger();
app.get("/getProducers_pooling", function (req, res) {
    controllers_1.EsencialController_pooling.getInstance().getProducers()
        .then(function (data) {
        res.json(data);
    })
        .catch(function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.get("/getProducers_no_pooling", function (req, res) {
    controllers_2.EsencialController_no_pooling.getInstance().getProducers()
        .then(function (data) {
        res.json(data);
    })
        .catch(function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.get("/getProducers_ORM", function (req, res) {
    controllers_3.EsencialController_ORM.getInstance().getProducers()
        .then(function (data) {
        res.json(data);
    })
        .catch(function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
