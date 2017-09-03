'use strict';

var ms = require('milsymbol');
var _ = require('lodash');

export function processSymbol(description) {
    var locualo = new ms.Symbol(description);
    var loQue = locualo.drawInstructions;
    var data =   { id : 1
        , symbolType :"none" 
        , path : locualo.asSVG()
        , cx : 0.45
        , cy : 0.45
        , r : 0.45
        , x : "String"
        , y : "String"
        , degree : "String"
        , textAnchor : "String"
        , fontSize : "String"
        , fontFamily : "String"
        , fontweight : "String"
        , factor : 0.45
        , stroke : "String"
        , strokewidth : "String"
        , strokedasharray : "String"
        , linecap : "String"
        , fill : "String"
        , fillopacity : "String"
        , drawChild: 0
        }
    
    return data;
};