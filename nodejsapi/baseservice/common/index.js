"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
exports.__esModule = true;
exports.Article = exports.Logger = void 0;
var logger_1 = require("./logger/logger");
__createBinding(exports, logger_1, "Logger");
var article_1 = require("./library/article");
__createBinding(exports, article_1, "Article");
