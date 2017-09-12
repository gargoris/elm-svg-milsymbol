'use strict';

var ms = require('milsymbol');
var _ = require('lodash');

export function processSymbol(description) {
    var locualo = new ms.Symbol(description);
    var loQue = locualo.drawInstructions;
    var m = _.reduce(loQue, function (acc, val){
        var valAct = acc[0] + 1;
        var t = []
        return [valAct, _.concat(acc[1], t)]
    }, [-1,[]]);
    var data =   { id : 1
        , symbolType :"PrimerPremio" 
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