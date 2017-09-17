'use strict';

var ms = require('milsymbol');
var _ = require('lodash');

export function processSymbol(description) {
    var data = {
         path:null
        , cx: null
        , cy: null
        , r: null
        , x: null
        , y: null
        , degree: null
        , textAnchor: null
        , fontSize: null
        , fontFamily: null
        , fontweight: null
        , factor: null
        , stroke: null
        , strokewidth: null
        , strokedasharray: null
        , linecap: null
        , fill: null
        , fillopacity: null
        , drawChild: null
    }
    var reduxFunction = function (acc, val) {
        var valAct = acc[0] + 1;
        var listAct = acc[1];
        //If the object has a list of draw, call this function over the list
        var t = _.omit(_.assign(data, _.assign(val, {
            id: valAct,
            symbolType: val.type
        })), ['draw', 'type']);

        return [valAct, _.concat(acc[1], t)]
    };
    var locualo = new ms.Symbol(description);
    var loQue = locualo.drawInstructions;
    var m = _.reduce(loQue, reduxFunction, [-1, []]);

    return {
        draws:
        m[1],
        props: null
    };
};