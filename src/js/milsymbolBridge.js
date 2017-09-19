'use strict';

var ms = require('milsymbol');
var _ = require('lodash');

export function processSymbol(description) {
    var data = {
        path: "",
        cx: 0,
        cy: 0,
        r: 0,
        x: "",
        y: "",
        degree: "",
        textAnchor: "",
        fontSize: "",
        fontFamily: "",
        fontweight: "",
        factor: 0,
        dP: null,
        linecap: "",
        drawParent: -1
    };
    var reduxFunction = function (acc, val) {
        var valAct = acc[0] + 1;
        var listAct = acc[1];
        //If the object has a list of draw, call this function over the list
        var t = _.omit(_.assign(data, _.assign(val, {
            id: valAct,
            symbolType: val.type,
            dP: {
                fill: val.fill,
                fillopacity: val.fillopacity,
                stroke: val.stroke,
                strokewidth: val.strokewidth,
                strokedasharray: val.strokedasharray
            }
        })), ['draw', 'type']);

        return [valAct, _.concat(acc[1], t)]
    };
    var locualo = new ms.Symbol(description);
    var loQue = locualo.drawInstructions;
    var m = _.reduce(loQue, reduxFunction, [-1, []]);

    return {
        draws: m[1],
        props: null
    };
};