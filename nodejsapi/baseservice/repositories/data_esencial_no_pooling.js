"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
exports.data_esencial_no_pooling = void 0;
var common_1 = require("../common");
var tedious_1 = require("tedious");
var sqlConfig = {
    server: "localhost",
    options: {
        database: "Esencial Verde",
        encrypt: true,
        trustServerCertificate: true,
        rowCollectionOnDone: true,
        rowCollectionOnRequestCompletion: true,
        useColumnNames: true
    },
    authentication: {
        type: "default",
        options: {
            userName: "dbuser",
            password: "123456789"
        }
    }
};
var data_esencial_no_pooling = /** @class */ (function () {
    function data_esencial_no_pooling() {
        this.connection = new tedious_1.Connection(sqlConfig);
        this.isConnected = false;
        this.log = new common_1.Logger();
    }
    data_esencial_no_pooling.getInstance = function () {
        if (!data_esencial_no_pooling.instance) {
            data_esencial_no_pooling.instance = new data_esencial_no_pooling();
        }
        return data_esencial_no_pooling.instance;
    };
    data_esencial_no_pooling.prototype.connect = function () {
        var _this = this;
        return new Promise(function (resolve, reject) {
            _this.connection.on("connect", function (err) {
                if (err) {
                    reject(err);
                }
                else {
                    _this.isConnected = true;
                    console.log('Connected with connection without pooling');
                    resolve();
                }
            });
            _this.connection.connect();
        });
    };
    data_esencial_no_pooling.prototype.getProducers = function () {
        return __awaiter(this, void 0, void 0, function () {
            var err_1;
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        _a.trys.push([0, 3, , 4]);
                        if (!!this.isConnected) return [3 /*break*/, 2];
                        // Check if the connection is already established
                        return [4 /*yield*/, this.connect()];
                    case 1:
                        // Check if the connection is already established
                        _a.sent();
                        _a.label = 2;
                    case 2: return [2 /*return*/, new Promise(function (resolve, reject) {
                            var request = new tedious_1.Request('get_producers', function (err, rowCount, rows) {
                                if (err) {
                                    console.error('Error executing database query:', err);
                                    reject(err);
                                }
                                else {
                                    resolve({ rows: rows });
                                }
                            });
                            _this.connection.callProcedure(request);
                        })];
                    case 3:
                        err_1 = _a.sent();
                        console.error('Error executing getProducers:', err_1);
                        throw err_1;
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    return data_esencial_no_pooling;
}());
exports.data_esencial_no_pooling = data_esencial_no_pooling;